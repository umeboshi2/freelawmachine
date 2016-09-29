# CourtListener Ansible playbooks

These are the playbooks used to build out the FreeLawMachine.

## Requirements
Requirements for running these playbooks are quite simple:

* [Ansible 2.x](https://github.com/ansible/ansible)
* [Vagrant 1.8.5](https://www.vagrantup.com)
* [Virtualbox 5.1.4](https://www.virtualbox.org/)

## Playbooks

There are two playbooks at the moment. One is designed to build out a complete
machine with all required services. The other is used to quickly update the
CourtListener application requirements, specifically the Python components.

* [freelawbox.yml](freelawbox.yml) - used for last-mile provisioning of
  CourtListener when launching the FreeLawMachine Vagrant box
* [freelawmachine.yml](freelawmachine.yml) - the whole enchilada, containing
  all the service roles...used to build a complete standalone CourtListener
  machine ready to run

## Roles

The playbooks all rely on some defined roles, each with their own playbooks and
supporting material.

### Celery
Installs and configures [Celery](http://www.celeryproject.org) as a service.

### CourtListener
The primary playbook for installing and configuring
[CourtListener](https://www.courtlistener.com)

### OCR
Installs and configures OCR functionality from Tesseract and Leptonica. Builds
them from source and installs them into the machine.

### Postgres
Installs the Ubuntu packages for PostgreSQL. Configures the database environment
for use with Django and md5-based password auth.

### Redis
Downloads and installs Redis while setting up as a service.

### Solr
Downloads and installs Solr. Pre-creates Solr cores in `/opt/solr-cores` to
make execution of CourtListener and any test code easier.

### Ubuntu-Trusty
Makes sure the Python environment is up to date and sets up some Ubuntu related
things like the system locale (needed for the database).

### Vagrantbox
Any vagrant-specific configuration. At the moment, simply sets the vagrant user
account to use BASH colors.
