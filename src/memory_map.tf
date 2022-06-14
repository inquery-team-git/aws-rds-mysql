// https://instances.vantage.sh/rds/
locals {
  instance_memory_map = {
    "db.m1.large"               = 7.5
    "db.m1.medium"              = 3.75
    "db.m1.small"               = 1.7
    "db.m1.xlarge"              = 15
    "db.m2.2xlarge"             = 34.2
    "db.m2.4xlarge"             = 68.4
    "db.m2.xlarge"              = 17.1
    "db.m3.2xlarge"             = 30
    "db.m3.large"               = 7.5
    "db.m3.medium"              = 3.75
    "db.m3.xlarge"              = 15
    "db.m4.10xlarge"            = 160
    "db.m4.16xlarge"            = 256
    "db.m4.2xlarge"             = 32
    "db.m4.4xlarge"             = 64
    "db.m4.large"               = 8
    "db.m4.xlarge"              = 16
    "db.m5.12xlarge"            = 192
    "db.m5.16xlarge"            = 256
    "db.m5.24xlarge"            = 384
    "db.m5.2xlarge"             = 32
    "db.m5.4xlarge"             = 64
    "db.m5.8xlarge"             = 128
    "db.m5.large"               = 8
    "db.m5.xlarge"              = 16
    "db.m5d.12xlarge"           = 192
    "db.m5d.16xlarge"           = 256
    "db.m5d.24xlarge"           = 384
    "db.m5d.2xlarge"            = 32
    "db.m5d.4xlarge"            = 64
    "db.m5d.8xlarge"            = 128
    "db.m5d.large"              = 8
    "db.m5d.xlarge"             = 16
    "db.m6g.12xlarge"           = 192
    "db.m6g.16xlarge"           = 256
    "db.m6g.2xlarge"            = 32
    "db.m6g.4xlarge"            = 64
    "db.m6g.8xlarge"            = 128
    "db.m6g.large"              = 8
    "db.m6g.xlarge"             = 16
    "db.m6i.12xlarge"           = 192
    "db.m6i.16xlarge"           = 256
    "db.m6i.24xlarge"           = 384
    "db.m6i.2xlarge"            = 32
    "db.m6i.32xlarge"           = 512
    "db.m6i.4xlarge"            = 64
    "db.m6i.8xlarge"            = 128
    "db.m6i.large"              = 8
    "db.m6i.xlarge"             = 16
    "db.r3.2xlarge"             = 61
    "db.r3.4xlarge"             = 122
    "db.r3.8xlarge"             = 244
    "db.r3.large"               = 15.25
    "db.r3.xlarge"              = 30.5
    "db.r4.16xlarge"            = 488
    "db.r4.2xlarge"             = 61
    "db.r4.4xlarge"             = 122
    "db.r4.8xlarge"             = 244
    "db.r4.large"               = 15.25
    "db.r4.xlarge"              = 30.5
    "db.r5.12xlarge.tpc2.mem2x" = 768
    "db.r5.12xlarge"            = 384
    "db.r5.16xlarge"            = 512
    "db.r5.24xlarge"            = 768
    "db.r5.2xlarge.tpc1.mem2x"  = 128
    "db.r5.2xlarge.tpc2.mem4x"  = 256
    "db.r5.2xlarge.tpc2.mem8x"  = 512
    "db.r5.2xlarge"             = 64
    "db.r5.4xlarge.tpc2.mem2x"  = 256
    "db.r5.4xlarge.tpc2.mem3x"  = 384
    "db.r5.4xlarge.tpc2.mem4x"  = 512
    "db.r5.4xlarge"             = 128
    "db.r5.6xlarge.tpc2.mem4x"  = 768
    "db.r5.8xlarge.tpc2.mem3x"  = 768
    "db.r5.8xlarge"             = 256
    "db.r5.large.tpc1.mem2x"    = 32
    "db.r5.large"               = 16
    "db.r5.xlarge.tpc2.mem2x"   = 64
    "db.r5.xlarge.tpc2.mem4x"   = 128
    "db.r5.xlarge"              = 32
    "db.r5b.12xlarge"           = 384
    "db.r5b.16xlarge"           = 512
    "db.r5b.24xlarge"           = 768
    "db.r5b.2xlarge"            = 64
    "db.r5b.4xlarge"            = 128
    "db.r5b.8xlarge"            = 256
    "db.r5b.large"              = 16
    "db.r5b.xlarge"             = 32
    "db.r5d.12xlarge"           = 384
    "db.r5d.16xlarge"           = 512
    "db.r5d.24xlarge"           = 768
    "db.r5d.2xlarge"            = 64
    "db.r5d.4xlarge"            = 128
    "db.r5d.8xlarge"            = 256
    "db.r5d.large"              = 16
    "db.r5d.xlarge"             = 32
    "db.r6g.12xlarge"           = 384
    "db.r6g.16xlarge"           = 512
    "db.r6g.2xlarge"            = 64
    "db.r6g.4xlarge"            = 128
    "db.r6g.8xlarge"            = 256
    "db.r6g.large"              = 16
    "db.r6g.xlarge"             = 32
    "db.r6i.12xlarge"           = 384
    "db.r6i.16xlarge"           = 512
    "db.r6i.24xlarge"           = 768
    "db.r6i.2xlarge"            = 64
    "db.r6i.32xlarge"           = 1024
    "db.r6i.4xlarge"            = 128
    "db.r6i.8xlarge"            = 256
    "db.r6i.large"              = 16
    "db.r6i.xlarge"             = 32
    "db.t1.micro"               = 0.613
    "db.t2.2xlarge"             = 32
    "db.t2.large"               = 8
    "db.t2.medium"              = 4
    "db.t2.micro"               = 1
    "db.t2.small"               = 2
    "db.t2.xlarge"              = 16
    "db.t3.2xlarge"             = 32
    "db.t3.large"               = 8
    "db.t3.medium"              = 4
    "db.t3.micro"               = 1
    "db.t3.small"               = 2
    "db.t3.xlarge"              = 16
    "db.t4g.2xlarge"            = 32
    "db.t4g.large"              = 8
    "db.t4g.medium"             = 4
    "db.t4g.micro"              = 1
    "db.t4g.small"              = 2
    "db.t4g.xlarge"             = 16
    "db.x1.16xlarge"            = 976
    "db.x1.32xlarge"            = 1952
    "db.x1e.16xlarge"           = 1952
    "db.x1e.2xlarge"            = 244
    "db.x1e.32xlarge"           = 3904
    "db.x1e.4xlarge"            = 488
    "db.x1e.8xlarge"            = 976
    "db.x1e.xlarge"             = 122
    "db.x2g.12xlarge"           = 768
    "db.x2g.16xlarge"           = 1024
    "db.x2g.2xlarge"            = 128
    "db.x2g.4xlarge"            = 256
    "db.x2g.8xlarge"            = 512
    "db.x2g.large"              = 32
    "db.x2g.xlarge"             = 64
    "db.z1d.12xlarge"           = 384
    "db.z1d.2xlarge"            = 64
    "db.z1d.3xlarge"            = 96
    "db.z1d.6xlarge"            = 192
    "db.z1d.large"              = 16
    "db.z1d.xlarge"             = 32
  }
}
