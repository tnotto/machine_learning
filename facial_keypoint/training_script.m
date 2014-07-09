clear all
row_import_count = 7050;
downscale = 1;
% zoom_width = 20;

[left_eye_center_x,left_eye_center_y,right_eye_center_x,right_eye_center_y,...
    left_eye_inner_corner_x,left_eye_inner_corner_y,left_eye_outer_corner_x,...
    left_eye_outer_corner_y,right_eye_inner_corner_x,right_eye_inner_corner_y,...
    right_eye_outer_corner_x,right_eye_outer_corner_y,left_eyebrow_inner_end_x,...
    left_eyebrow_inner_end_y,left_eyebrow_outer_end_x,left_eyebrow_outer_end_y,...
    right_eyebrow_inner_end_x,right_eyebrow_inner_end_y,right_eyebrow_outer_end_x,...
    right_eyebrow_outer_end_y,nose_tip_x,nose_tip_y,mouth_left_corner_x,...
    mouth_left_corner_y,mouth_right_corner_x,mouth_right_corner_y,...
    mouth_center_top_lip_x,mouth_center_top_lip_y,mouth_center_bottom_lip_x,...
    mouth_center_bottom_lip_y,Image] = import_all('training.csv', 2, row_import_count);

% training_output = cat(2, left_eye_center_x,left_eye_center_y,right_eye_center_x,right_eye_center_y,...
%     left_eye_inner_corner_x,left_eye_inner_corner_y,left_eye_outer_corner_x,...
%     left_eye_outer_corner_y,right_eye_inner_corner_x,right_eye_inner_corner_y,...
%     right_eye_outer_corner_x,right_eye_outer_corner_y,left_eyebrow_inner_end_x,...
%     left_eyebrow_inner_end_y,left_eyebrow_outer_end_x,left_eyebrow_outer_end_y,...
%     right_eyebrow_inner_end_x,right_eyebrow_inner_end_y,right_eyebrow_outer_end_x,...
%     right_eyebrow_outer_end_y,nose_tip_x,nose_tip_y,mouth_left_corner_x,...
%     mouth_left_corner_y,mouth_right_corner_x,mouth_right_corner_y,...
%     mouth_center_top_lip_x,mouth_center_top_lip_y,mouth_center_bottom_lip_x,...
%     mouth_center_bottom_lip_y);

image_data = zeros(row_import_count, 9216);
% downsized_image = zeros(row_import_count-1, (96/downscale)^2);
% cropped_center = zeros(row_import_count-1, zoom_width^2, 15);
parfor i = 1:(row_import_count-1);
    image_data(i,:) = str2num(cell2mat(Image(i)));
%     
%     downsizes the original image by factor defined above. 
%     original_plot_image = reshape(image_data(i,:),96, 96);
%     plot_image = imresize(original_plot_image, 1/downscale, 'bicubic');
%     plot_image = downsample(original_plot_image, downscale);
%     plot_image = downsample(plot_image', downscale);
%     downsized_image(i,:) = reshape(plot_image, 1, (96/downscale)^2);
    
% %     plots the original image, then the downsized image, and then plots
% %     the estimated keypoints on the original using the initial pass nn
%     Y = trained_initial_nn(downsized_image(i,:));
%     point = trained_j1(X(i,:)');
%     figure(2); imagesc(plot_image); colormap('gray');
%     figure(1); imagesc(original_plot_image'); colormap('gray'); hold on;
%     for j=1:15
%         X = cropped_center(:,:,j);
%         if j==1;
%             K = trained_j1_20(X(i,:)');
%         elseif j==2;
%             K =trained_j2(X(i,:)');
%         elseif j==3;
%             K =trained_j3(X(i,:)');
%         elseif j==4;
%             K =trained_j4(X(i,:)');
%         elseif j==5;
%             K =trained_j5(X(i,:)');
%         elseif j==6;
%             K =trained_j6(X(i,:)');
%         elseif j==7;
%             K =trained_j7(X(i,:)');
%         elseif j==8;
%             K =trained_j8(X(i,:)');   
%         elseif j==9;
%             K =trained_j9(X(i,:)');    
%         elseif j==10;
%             K =trained_j10(X(i,:)');    
%         elseif j==11;
%             K =trained_j11(X(i,:)'); 
%         elseif j==12;
%             K =trained_j12(X(i,:)');
%         elseif j==13;
%             K =trained_j13(X(i,:)');    
%         elseif j==14;
%             K =trained_j14(X(i,:)'); 
%         elseif j==15;
%             K =trained_j15(X(i,:)');
%         else
%             'blah'
%         end;
%             
%             
%         plot(Y(2*j-1,i), Y(2*j,i), 'o');
%         plot(training_output(i,2*j-1), training_output(i,2*j), '*') 
%         plot(K(1),K(2), 'x')
%     end;
%      plot(point(1),point(2),'o')
%      plot(training_output(i,1),training_output(i,2), 'x')
%      plot(point1(1),point1(2),'*')
%      plot(Y(1,i), Y(2,i), 'o')
%      pause(10)

% %     zooms in on points identified in the first pass by nn
%     for j = 1:15;
%         xmin = (round(training_output(i,2*j-1))-10);
%         ymin = (round(training_output(i,2*j))-10);
%         if or(isnan(xmin),isnan(ymin))
%             continue;
%         else 
%             if and((96-xmin)<zoom_width,(96-ymin)<zoom_width);
%                 cropped = imcrop(reshape(image_data(i,:),96, 96)',...
%                     [(96-zoom_width) (96-zoom_width) (zoom_width-1) (zoom_width-1)]);
%             elseif (96-ymin)<zoom_width;
%                 cropped = imcrop(reshape(image_data(i,:),96, 96)',...
%                     [xmin (96-zoom_width) (zoom_width-1) (zoom_width-1)]);   
%             elseif (96-xmin)<zoom_width;
%                 cropped = imcrop(reshape(image_data(i,:),96, 96)',...
%                     [(96-zoom_width) ymin (zoom_width-1) (zoom_width-1)]); 
%             elseif and(xmin<1,ymin<1);
%                 cropped = imcrop(reshape(image_data(i,:),96, 96)',...
%                     [1 1 (zoom_width-1) (zoom_width-1)]);
%             elseif ymin<1;
%                 cropped = imcrop(reshape(image_data(i,:),96, 96)',...
%                     [xmin 1 (zoom_width-1) (zoom_width-1)]);   
%             elseif xmin<1;
%                 cropped = imcrop(reshape(image_data(i,:),96, 96)',...
%                     [1 ymin (zoom_width-1) (zoom_width-1)]); 
%             else
%                 cropped = imcrop(reshape(image_data(i,:),96, 96)',...
%                     [xmin ymin (zoom_width-1) (zoom_width-1)]);
%             end;
%             cropped_center(i,:,j) = reshape(cropped, 1, (zoom_width)^2);
%         end;
%     end;
    
end;

% % below is a script for training a nn and saving a nn function for the trained nn
% Solve an Input-Output Fitting problem with a Neural Network
% Script generated by Neural Fitting app
% Created Thu Jun 12 06:21:13 PDT 2014
%
% This script assumes these variables are defined:
%
%   downsized_image - input data.
%   training_output - target data.
% 
% x = downsized_image';
% t = training_output';
% 
% % Choose a Training Function
% % For a list of all training functions type: help nntrain
% % 'trainlm' is usually fastest.
% % 'trainbr' takes longer but may be better for challenging problems.
% % 'trainscg' uses less memory. NFTOOL falls back to this in low memory situations.
% trainFcn = 'trainlm';  % Levenberg-Marquardt
% 
% % Create a Fitting Network
% hiddenLayerSize = 10;
% net = fitnet(hiddenLayerSize,trainFcn);
% 
% % Choose Input and Output Pre/Post-Processing Functions
% % For a list of all processing functions type: help nnprocess
% net.input.processFcns = {'removeconstantrows','mapminmax'};
% net.output.processFcns = {'removeconstantrows','mapminmax'};
% 
% % Setup Division of Data for Training, Validation, Testing
% % For a list of all data division functions type: help nndivide
% net.divideFcn = 'dividerand';  % Divide data randomly
% net.divideMode = 'sample';  % Divide up every sample
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 15/100;
% 
% % Choose a Performance Function
% % For a list of all performance functions type: help nnperformance
% net.performFcn = 'mse';  % Mean squared error
% 
% % Choose Plot Functions
% % For a list of all plot functions type: help nnplot
% net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
%   'plotregression', 'plotfit'};
% 
% % Train the Network
% [net,tr] = train(net,x,t);
% 
% % Test the Network
% y = net(x);
% e = gsubtract(t,y);
% performance = perform(net,t,y)
% 
% % Recalculate Training, Validation and Test Performance
% trainTargets = t .* tr.trainMask{1};
% valTargets = t  .* tr.valMask{1};
% testTargets = t  .* tr.testMask{1};
% trainPerformance = perform(net,trainTargets,y)
% valPerformance = perform(net,valTargets,y)
% testPerformance = perform(net,testTargets,y)
% 
% % View the Network
% view(net)
% 
% % Plots
% % Uncomment these lines to enable various plots.
% % figure, plotperform(tr)
% % figure, plottrainstate(tr)
% % figure, plotfit(net,x,t)
% % figure, plotregression(t,y)
% % figure, ploterrhist(e)
% 
% % Deployment
% % Change the (false) values to (true) to enable the following code blocks.
% if (true)
%   % Generate MATLAB function for neural network for application deployment
%   % in MATLAB scripts or with MATLAB Compiler and Builder tools, or simply
%   % to examine the calculations your trained neural network performs.
%   genFunction(net,'myNeuralNetworkFunction');
%   y = myNeuralNetworkFunction(x);
% end
% if (false)
%   % Generate a matrix-only MATLAB function for neural network code
%   % generation with MATLAB Coder tools.
%   genFunction(net,'myNeuralNetworkFunction','MatrixOnly','yes');
%   y = myNeuralNetworkFunction(x);
% end
% if (false)
%   % Generate a Simulink diagram for simulation or deployment with.
%   % Simulink Coder tools.
%   gensim(net);
% end
