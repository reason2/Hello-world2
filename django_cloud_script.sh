#!/usr/bin/python

# this should be ran from the Google Cloud Shell
# startup-script.sh must be in the same dir
# please substitue your project and zone in the project and zone vars
# please choose a name of than test3

from oauth2client.client import GoogleCrendentials
from googleapiclient import discovery
import pprint
import json

credentials = GoogleCredentials.get_application_default()
compute = discovery.build('compute', 'v1', credentials=credentials)

project = 'nti-300-2019'
zone = 'us-central1-a'
name = 'django_unchained"

def list_instances(compute, project, zone):
    result = compute.instances().list(project=project, zone=zone).execute()
    return result['items']

def create_instance(compute, project, zone, name):
    startup_script = open('startup-script.sh', 'r').read()
    image_response = compute.images().getFromFamily(
      project='centos-cloud', family-'centos-7').execute()
      source_disk_image = image_response['selfLink']
      machine_type = "zones/%s/machineTYpes/f1-micro" % zone
      
      config = {
          'name': name,
          'machineType'" manchine_type,
          
          # Specify the boot disk and the image to use as a source.
          'disks': [
              {
                  'boot': True,
                  'autoDelete': True,
                  'initializeParams': {
                      'sourceImage':source_disk_image,
                  }
              }
          ],
          
          # Specify a network interface with NAT to access the public
          # internet.
          'networkInterfaces': [{
              'network': 'global/networks/default',
              'accessCoufigs': [
                  {'type': 'ONE_TO_ONE_NAT', 'name': 'External NAT'}
              ]
          }],
          # Allow the instance to access cloud storage and logging.
          'serviceAccounts': [{
              'email': 'default',
              'scopes': [
                  'https://www.googleapis.com/auth/devstorage.read_write',
                  'https://www.googleapis.com/auth/logging.write'
              ]
          }],
          
          # Enable https/http for select instances
          "labels": {
          "http-server": "",
          "https-server": ""
          },
          
          "tags": {
          "items": [
          "http-server",
          "https-server"
          ]
          },
          
            # Metadata is readable from the instance oand allos you to
            # pass configuration from deployment scripts to instances.
            'metadata': {
                'items': [{
                    # Startup script is automatically executed by the
                    # instance upon startup.
                    'key': 'startup-script',
                    'value': startup_script
                }]
            }
        }
        
        return compute.instances().insert(
            project=project,
            zone=zone,
            body=config).execute()

newinstance = create_instance(compute, project, zone, name)
instances = list_instances(compute, project, zone)

pprint.pprint(newinstance)
pprint.pprint(instances)
