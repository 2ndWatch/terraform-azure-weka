prefix              = "ja-weka"
rg_name             = "jacton-weka"
vnet_name           = "jacton-weka-vnet"
subnet_name         = "jacton-weka-snet"
subnet_delegation   = "10.1.8.0/25"
cluster_name        = "cluster"
private_network     = true
install_weka_url    = "https://wekadeploytars.blob.core.windows.net/tars/weka-4.1.0.71.tar"
instance_type       = "Standard_L8s_v3"
set_obs_integration = true
tiering_ssd_percent = 20
cluster_size        = 6