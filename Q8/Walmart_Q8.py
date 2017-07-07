
# coding: utf-8

# In[226]:

import pandas as pd
import xlwt


# In[227]:

# IMPORTING THE CLUBS FILE

df=pd.read_csv('C:\\Walmart\\Club List.csv', sep=',',header=None)
df.columns=['Clubs']

# Sorting the columns - makes it easier to compute huge lists
SortedClubdf = df.sort_values(['Clubs'],ascending=[1])

# Reindexed according to the sorted column
SortedClubdf.index = range(0, len(SortedClubdf))

##print(SortedClubdf)
Clublen=SortedClubdf.shape[0]


# In[228]:

# IMPORTING THE ITEMS FILE

Itemdf=pd.read_csv('C:\\Walmart\\Item List.csv', sep=',',header=None)
Itemdf.columns=['Items']

# Sorting the columns - makes it easier to work with huge lists
SortedItemdf = Itemdf.sort_values(['Items'],ascending=[1])

# Reindexed according to the sorted column
SortedItemdf.index = range(0, len(SortedItemdf))

##print(SortedItemdf)
Itemlen=SortedItemdf.shape[0]


# In[229]:

# IMPORTING THE CLUB-ITEM FILE

CIdf=pd.read_csv('C:\\Walmart\\ClubItem.csv', sep=',',header=None)
CIdf.columns=['Club','Item']

##print(CIdf)
CIlen=CIdf.shape[0]


# In[230]:

# USING NUMPY DATAFRAME FOR EFFICIENCY

matrix=(numpy.zeros(shape=(Itemlen,Clublen)))
#print(matrix)


# In[231]:

# FLAGGING MATRIX FOR CLUB-ITEM COMBINATIONS

for i in range(CIdf.shape[0]):
    col=Sorteddf[Sorteddf['Clubs']==CIdf['Club'][i]].index[0]
    row=SortedItemdf[SortedItemdf['Items']==CIdf['Item'][i]].index[0]
    matrix[row][col]=1
    #print(row,col)
#print(matrix)


# In[232]:

#CREATING OUTPUT MATRIX AS AN EXCEL FILE 

# Initialize a workbook 
book = xlwt.Workbook(encoding="utf-8")

# Add a sheet to the workbook 
sheet1 = book.add_sheet("Output") 

# Write to the sheet of the workbook 

# Writing Clubs in first row
for i in range(Clublen):
    sheet1.write(0,i+1,Sorteddf['Clubs'][i]) 

# Writing Items in first column
for j in range(Itemlen):
    sheet1.write(j+1,0,SortedItemdf['Items'][j]) 

# Adding Y for found Club-Item records
for a in range(Itemlen):
    for b in range(Clublen):
        if matrix[a][b]==1:
            sheet1.write(a+1,b+1,'Y')           #Converted 1 to Y in Excel file
    
# Save the workbook 
book.save("C:\\Walmart\\Output Matrix.xls")

