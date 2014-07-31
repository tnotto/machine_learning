import pandas
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
import numpy as np

cat_columns = ['C1','C2','C3','C4','C5','C6','C7','C8',
            'C9','C10','C11','C12','C13','C14','C15','C16',
            'C17','C18','C19','C20','C21','C22','C23','C24',
            'C25','C26']

int_columns = ['I1','I2','I3','I4','I5','I6','I7','I8',
            'I9','I10','I11','I12','I13']

def str_to_cat(Nrows = 10000):
    data = pandas.read_csv('xaa.csv', nrows=Nrows)

    for col in cat_columns:
        data[col] = data[col].apply(str)
        le = LabelEncoder()
        le.fit(data[col])
        data[col] = le.transform(data[col])

    return data
        
def OHE(data):

    enc = OneHotEncoder()
    enc.fit(data[cat_columns])
    data1 = enc.transform(data[cat_columns]).toarray()
    new_data = np.zeros((len(data1), len(data1[0])+len(int_columns)))
    data = data.fillna(0)

    for i in range(len(data1)):
        new_data[i] = np.append(data1[i], list(data[int_columns].loc[i].values))

    return (new_data, np.array(data['Label']))
