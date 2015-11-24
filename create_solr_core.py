#!/usr/bin/python
from cl.lib.solr_core_admin import create_solr_core
from cl import settings
import os


create_solr_core(
   core_name='audio',
   data_dir=os.path.join(settings.INSTALL_ROOT, 'Solr', 'data_audio'),
   schema=os.path.join(settings.INSTALL_ROOT, 'Solr', 'conf', 'audio_schema.xml'),
   instance_dir='/usr/local/solr/example/solr/audio',
)
