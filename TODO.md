# TODO!
Just some personal reminders...

* ~~configure ssh keys for _vagrant_ user~~
* ~~install dependencies for [CourtListener](https://github.com/freelawproject/courtlistener)~~
* clean-up [preseed.cfg](./http/preseed.conf) removing settings not needed
* properly configure Vagrantfile for default file mappings.
  * ~~ideal situation is the user doesn't need to even install Git locally on
  their workstation~~
    * silly rabbit...for this vm to be at all useful sans-gui we need the host
    to have the code locally, yet executed within the guest
  * ~~Vagrant box should have all dev tools needed so all the user needs is an
  editor (or use nano/vim/whatever) and a web browser~~
* figure out how to de-couple Solr for dev purposes
