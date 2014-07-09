import json
import csv

def jsonify():
    with open('test2.csv', 'r') as f:
        fieldnames = ('left_eye_center_x','left_eye_center_y','right_eye_center_x','right_eye_center_y','left_eye_inner_corner_x','left_eye_inner_corner_y','left_eye_outer_corner_x','left_eye_outer_corner_y','right_eye_inner_corner_x','right_eye_inner_corner_y','right_eye_outer_corner_x','right_eye_outer_corner_y','left_eyebrow_inner_end_x','left_eyebrow_inner_end_y','left_eyebrow_outer_end_x','left_eyebrow_outer_end_y','right_eyebrow_inner_end_x','right_eyebrow_inner_end_y','right_eyebrow_outer_end_x','right_eyebrow_outer_end_y','nose_tip_x','nose_tip_y','mouth_left_corner_x','mouth_left_corner_y','mouth_right_corner_x','mouth_right_corner_y','mouth_center_top_lip_x','mouth_center_top_lip_y','mouth_center_bottom_lip_x','mouth_center_bottom_lip_y')
        data = csv.DictReader(f, fieldnames)
        with open('json_data.json', 'w') as jsonfile:
            for row in data:
                json.dump(row, jsonfile)
                jsonfile.write('\n')

def json_to_list():
    with open('json_data.json', 'r') as f:
        data = f.read().splitlines()
        data_list = []
        for row in data:
            jsondata = json.loads(row)
            data_list.append(jsondata)

    return data_list

def list_to_submission():
    solutions = json_to_list()
    with open('original_data/IdLookupTable.csv', 'r') as readfile:
        data = csv.reader(readfile)
        i = 0
        with open('submission_3factor.csv', 'w') as writefile:
            rowwriter = csv.writer(writefile, delimiter=',')
            for row in data:
                if i > 0:
                    R = float(solutions[int(row[1])-1][row[2]])
                    if R<=0:
                        R = 0
                    elif R >96:
                        R = 96
                    else:    
                        R = R
                    rowwriter.writerow([row[0], R ])
                    i+=1
                else:
                    rowwriter.writerow(['RowId','Location'])
                    i += 1
                    pass
            
            # print row, solutions[int(row[1])-1][row[2]]
            
