Puppet::Type.newtype(:gce_disk) do

  desc 'creates a persistent disk image'

  ensurable

  newparam(:name, :namevar => true) do
    desc 'name of disk to create'
    validate do |v|
      unless v =~ /[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?/
        raise(Puppet::Error, "Invalid disk name: #{v}")
      end
    end
  end

  # NOTE this could be a property eventually b/c
  # it is possible to migrate disks between zones
  #
  newparam(:zone) do
    desc 'zone where this disk lives'
  end

  newparam(:size_gb) do
    desc 'size in GB for disk'
  end

  newparam(:description) do
    desc 'description of disk'
  end

  newparam(:source_image) do
    desc 'boot image to use when creating disk'
  end

  newparam(:wait_until_complete) do
    desc 'wait until disk is complete'
  end

  validate do
    raise(Puppet::Error, 'Must specify a zone for the disk') unless self[:zone]
  end

end
