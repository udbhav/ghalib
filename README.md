Ghalib
------

Development machine for Rails and Django projects.

    vagrant plugin install vagrant-omnibus
    vagrant plugin install vagrant-berkshelf
    vagrant plugin install vagrant-vbguest
    vagrant up

For shared folders, create a file called shared_folders.json like this:

    [["relative_path/on/host", "/path/on/guest"],["/path2","/path/on/guest"]]