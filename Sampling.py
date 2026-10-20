import pandas as pd

input_file = r"D:\financial-transactions-bi-dashboard\data\raw\paysim dataset.csv"
output_file = r"D:\financial-transactions-bi-dashboard\data\sample\paysim_sample_100k.csv"

df = pd.read_csv(input_file, nrows=100000)
df.to_csv(output_file, index=False)

print(df.shape)
print(df.head())
