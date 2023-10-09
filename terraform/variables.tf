variable "project_id" {
  type        = string
  description = "The ID of the project in which resources will be deployed"
}

variable "issuer_uri" {
  type        = string
  description = "Workload Identity Pool Issuer URL"
  default     = "https://token.actions.githubusercontent.com"
}

variable "pool_id" {
  type        = string
  description = "Workload Identity Pool ID"
}

variable "provider_id" {
  type        = string
  description = "Workload Identity Pool Provider id"
}

variable "sa_mapping_attribute" {
  type        = string
  description = "WIF provider attributes"
}

variable "sa_name" {
  type        = string
  description = "Name of the Google service account to be created"
}

variable "location" {
  type        = string
  description = "The name of the location this repository is located in"
}

variable "repository_id" {
  type        = string
  description = "The last part of the repository name, for example:repo1"
}

variable "network_name" {
  type        = string
  description = "Name of the VPC network"
}

variable "subnets" {
  type        = list(map(string))
  description = "The list of subnets being created"
}

variable "secondary_ranges" {
  type = map(list(object({
    range_name = string,
  ip_cidr_range = string })))
  description = "Secondary ranges that will be used in some of the subnets"
  default     = {}
}

variable "cluster_name" {
  type        = string
  description = "Name of the GKE cluster"
}

variable "region" {
  type        = string
  description = "The region to host the cluster in"
}

variable "ip_range_pods" {
  type        = string
  description = "The name of the secondary subnet ip range to use for pods"
}

variable "ip_range_services" {
  type        = string
  description = "The name of the secondary subnet range to use for services"

}

variable "node_pools" {
  type        = list(map(string))
  description = "List of maps containing node pools"
}

variable "node_pools_labels" {
  type        = map(map(string))
  description = "Map of maps containing node labels by node-pool name"
  default     = {}
}