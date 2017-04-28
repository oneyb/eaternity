
# coding: utf-8

# In[19]:

import config
import pandas as pd
import seaborn as sns
import os
get_ipython().magic('matplotlib inline')
pd.set_option('display.notebook_repr_html', False)
pd.set_option('display.max_columns', 10)
pd.set_option('display.max_rows', 10)


# In[5]:

if 'data' not in globals().keys():
    fpath = os.path.join(config.DHOME, 'merged.csv.gz')
    # print(fpath)
    data = pd.read_csv(fpath, compression='gzip', encoding='mac_roman')



# In[6]:

# set date column
data['dt'] = pd.to_datetime(data.Date, format='%m-%Y')
data.set_index(['dt'], inplace=True)


# In[7]:

data.info()


# In[8]:

# No. of restaurants
len(data['name'].unique())


# In[10]:

get_ipython().magic('pinfo data.groupby')


# In[16]:

get_ipython().magic('pinfo pd.Series.sort_values')


# In[18]:

data.groupby(['Kitchen_ID'])['Total_CO2_kg'].median().sort_values(ascending=False)


# In[ ]:

sns.

