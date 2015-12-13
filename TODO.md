# TODO!
Just some personal reminders...

## Short Term
* put common packer settings in a shared ruby file used by the packer json files
  * e.g. one place for version number
  * e.g. one place for virtualbox-iso settings
* find a way to reduce disk space. candidates:
  * seal rookery
  * apache? not sure the size...but should maybe have 1 box without (for pure
    dev) and one box with (mimicing a prod box for functional testing)

## Long Term
* automate tests for box builds
* clean-up [preseed.cfg](./http/preseed.conf) removing settings not needed
* set Solr service to start at boot (prevents issues if someone restarts/halts)
* figure out how to de-couple Solr for dev purposes
