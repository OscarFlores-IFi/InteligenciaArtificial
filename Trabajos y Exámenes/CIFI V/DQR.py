import pandas as pd

def dqr(data):
    import pandas as pd    
    
    columns = pd.DataFrame(list(data.columns.values),columns=['Nombres'],index=list(data.columns.values))
    d_types = pd.DataFrame(data.dtypes,columns=['tipo'])
    missing_val = pd.DataFrame(data.isnull().sum(),columns=['Valores perdidos'])
    present_values = pd.DataFrame(data.count(),columns=['Valores presentes'])
    unique_values = pd.DataFrame(data.nunique(),columns=['Valores unicos'])
    
    
    min_values = pd.DataFrame(columns=['Min'])
    max_values = pd.DataFrame(columns=['Max'])
    for col in list(data.columns.values):
        try:
            min_values.loc[col] = [data[col].min()]
            max_values.loc[col] = [data[col].max()]
        except:
            pass
    
    reporte_calidad_datos = columns.join(d_types).join(missing_val).join(present_values).join(unique_values).join(min_values).join(max_values)
    
    return (reporte_calidad_datos)


DQR = dqr(pd.read_csv('Digitt.csv'))