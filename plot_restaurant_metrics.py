#!/usr/bin/env python

import config
import pandas as pd
import os
# import gzip

if 'data' not in globals().keys():
    fpath = os.path.join(config.DHOME, 'merged.csv.gz')
    print(fpath)
    data = pd.read_csv(fpath, compression='gzip', encoding='mac_roman')

print(data.head())
