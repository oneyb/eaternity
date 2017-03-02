
# coding: utf-8

# In[1]:

from brightway2 import *



# In[2]:

projects.set_current('Olive oil')


# In[ ]:

sp = SimaProCSVImporter('/home/oney/documents/eaternity/data/zhaw_simapro_olivenöl.csv', 'Olive-oil')
sp.statistics()


# In[5]:

bw2setup()


# In[6]:

sp.migrate('simapro-ecoinvent-3.3')


# In[7]:

sp.migrate('default-units')


for d in sp:
    print(type(d))

# In[33]:

sp.match_database('ecoinvent 3.3', ignore_categories=True)


# In[34]:


# In[35]:

db = Database('ecoinvent 3.3')


# In[36]:

import functools
from bw2io.strategies import link_iterable_by_fields

sp.apply_strategy(functools.partial(
        link_iterable_by_fields, 
        other=Database('ecoinvent 3.2 cutoff'),
        kind='technosphere',
        fields=['reference product', 'name', 'unit', 'location']
))
sp.statistics()


# In[37]:

sp2.apply_strategy(functools.partial(
        link_iterable_by_fields, 
        other=Database('ecoinvent 3.2 cutoff'),
        kind='technosphere',
        fields=['reference product', 'name', 'unit', 'location']
))
sp2.statistics()


# In[38]:

for i, e in enumerate(sp.unlinked):
    print(e['name'], e['unit'], e['categories'])
    if i > 20:
        break


# In[39]:

db.search('ENTSO')


# In[40]:

migration_data = {
    'fields': ['name'],
    'data': [
        (
            # First element is input data in the order of `fields` above
            ('Electricity, low voltage {ENTSO-E}| market group for | Alloc Rec, U',),
            # Second element is new values 
            {
                'name': 'market group for electricity, low voltage',
                'reference product': 'electricity, high voltage',
                'location': 'ENTSO-E',
            }
        )
    ]
}

Migration('new-ecoinvent').write(
    migration_data, 
    description='New datasets in ecoinvent 3.2'
)


# In[41]:

sp.migrate('new-ecoinvent')


# In[43]:

sp.match_database('ecoinvent 3.3', ignore_categories=True)


# In[56]:

sp.statistics()


# In[57]:

for i, e in enumerate(sp2.unlinked):
    print(e['name'], e['unit'], e['categories'])
    if i > 20:
        break


# In[58]:

migration_data2 = {
    'fields': ['name'],
    'data': [
        (
            # First element is input data in the order of `fields` above
            ('Electricity, low voltage {UCTE}| market group for | Alloc Rec, U',),
            # Second element is new values 
            { 
                'name': 'market group for electricity, low voltage',
                'reference product': 'electricity, low voltage',
                'location': 'UCTE',
            }
        )
    ]
}

Migration('new-ecoinvent2').write(
    migration_data2, 
    description='New datasets in ecoinvent 3.2'
)


# In[59]:

sp2.migrate('new-ecoinvent2')


# In[60]:

sp2.match_database('ecoinvent 3.3', ignore_categories=True)


# In[61]:

sp2.statistics()


# In[62]:

test = sp.write_database()


# In[ ]:

sp2.statistics()


# In[37]:

sp2.write_database()


# In[38]:

bouillon = Database('Bouillion')


# In[ ]:




# In[39]:

sp2.write_excel()


# In[40]:

sp.match_database('Bouillion',ignore_categories=True)


# In[41]:

sp.statistics()


# In[ ]:




# In[42]:

sp.write_excel()


# In[ ]:




# In[ ]:




# In[43]:

sp.write_database()


# In[44]:

bouillon = Database('Bouillion')


# In[45]:

bouillonZ = Database('Bouillon-Zutaten')


# In[46]:

list(bouillon)


# In[47]:

list(databases)


# # calculate LCIA

# try first sth from ecoinvent

# In[51]:

act = Database("ecoinvent 3.2 cutoff").search("pineapple")
act


# In[52]:

act = Database("ecoinvent 3.2 cutoff").search("pineapple")[1]
act


# In[53]:

lca = LCA(
    {act.key: 1}, 
    method=('IPCC 2013', 'climate change', 'GWP 100a'),
)
lca.lci()
lca.lcia()
lca.score


# try now for bouillon

# In[63]:

bou = Database("bouillon").search("Paste")
bou


# In[68]:

lca = LCA(
    demand={bouillon.random(): 1}, 
    method=('IPCC 2013', 'climate change', 'GWP 100a'),
)
lca.lci()
lca.lcia()
lca.score


# In[69]:

lca = LCA(
    demand={bouillonZ.random(): 1}, 
    method=('IPCC 2013', 'climate change', 'GWP 100a'),
)
lca.lci()
lca.lcia()
lca.score


# FRAGEN
# - stimmt das, dass  bouillon z  in bouillon einfliesst?
# - wie weiss ich sicher, dass ich gem[sebouillon ausgewaehlt habe?

# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:



