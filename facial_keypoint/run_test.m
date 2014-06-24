clear all
test_file = 'test.csv';
downscale = 4;
zoom_width = 20;

[ImageId,test_image] = import_test(test_file);

image_data = zeros(length(ImageId)-1, 9216);
downsized_image = zeros(length(ImageId)-1, (96/downscale)^2);
rough_point = zeros(30, length(ImageId)-1);
cropped_center = zeros(length(ImageId)-1, zoom_width^2, 15);
results = zeros(30, length(ImageId)-1);
for i = 2:(length(ImageId));
    image_data(i-1,:) = str2num(cell2mat(test_image(i)));
    plot_image = reshape(image_data(i-1,:),96, 96);
    plot_image = downsample(plot_image, downscale);
    plot_image = downsample(plot_image', downscale);
    downsized_image(i-1,:) = reshape(plot_image, 1, (96/downscale)^2); 
    rough_point(:,i-1) = trained_initial_nn(downsized_image(i-1,:)');
    
    for j = 1:15;
        xmin = (round(rough_point(2*j-1,i-1))-10);
        ymin = (round(rough_point(2*j,i-1))-10);
        if or(isnan(xmin),isnan(ymin))
            continue;
        else 
            if and((96-xmin)<zoom_width,(96-ymin)<zoom_width);
                cropped = imcrop(reshape(image_data(i-1,:),96, 96)',...
                    [(96-zoom_width) (96-zoom_width) (zoom_width-1) (zoom_width-1)]);
            elseif (96-ymin)<zoom_width;
                cropped = imcrop(reshape(image_data(i-1,:),96, 96)',...
                    [xmin (96-zoom_width) (zoom_width-1) (zoom_width-1)]);   
            elseif (96-xmin)<zoom_width;
                cropped = imcrop(reshape(image_data(i-1,:),96, 96)',...
                    [(96-zoom_width) ymin (zoom_width-1) (zoom_width-1)]); 
            elseif and(xmin<1,ymin<1);
                cropped = imcrop(reshape(image_data(i-1,:),96, 96)',...
                    [1 1 (zoom_width-1) (zoom_width-1)]);
            elseif ymin<1;
                cropped = imcrop(reshape(image_data(i-1,:),96, 96)',...
                    [xmin 1 (zoom_width-1) (zoom_width-1)]);   
            elseif xmin<1;
                cropped = imcrop(reshape(image_data(i-1,:),96, 96)',...
                    [1 ymin (zoom_width-1) (zoom_width-1)]); 
            else
                cropped = imcrop(reshape(image_data(i-1,:),96, 96)',...
                    [xmin ymin (zoom_width-1) (zoom_width-1)]);
            end;
            cropped_center(i-1,:,j) = reshape(cropped, 1, (zoom_width)^2);
            
        end;
        
        X = cropped_center(:,:,j);
        if j==1;
            K = trained_j1_20(X(i-1,:)');
        elseif j==2;
            K =trained_j2(X(i-1,:)');
        elseif j==3;
            K =trained_j3(X(i-1,:)');
        elseif j==4;
            K =trained_j4(X(i-1,:)');
        elseif j==5;
            K =trained_j5(X(i-1,:)');
        elseif j==6;
            K =trained_j6(X(i-1,:)');
        elseif j==7;
            K =trained_j7(X(i-1,:)');
        elseif j==8;
            K =trained_j8(X(i-1,:)');   
        elseif j==9;
            K =trained_j9(X(i-1,:)');    
        elseif j==10;
            K =trained_j10(X(i-1,:)');    
        elseif j==11;
            K =trained_j11(X(i-1,:)'); 
        elseif j==12;
            K =trained_j12(X(i-1,:)');
        elseif j==13;
            K =trained_j13(X(i-1,:)');    
        elseif j==14;
            K =trained_j14(X(i-1,:)'); 
        elseif j==15;
            K =trained_j15(X(i-1,:)');
        else
            'blah'
        end;
        results(2*j-1,i-1) = K(1);
        results(2*j,i-1) = K(2);
            
       end;
end;