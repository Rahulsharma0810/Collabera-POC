# Collabera-POC

For Diagram Please refer Email reply.

## Init

For Zero Trust architecture, We are not using Service Account Json key, Thus Worklaad Identity federation needed to be deployed initially, So Github Runner Can access GCP.

- terraform init
- terraform plan
- terraform apply

### Further Implmentations

- Private Cluster
- Use IAP to access GKE Pvt Cluster
- D
- Binary Authorization for adding layer of security, what can be deployed on the cluster
- Cert-Manager for providing issuence and rotating for ingress SSL.
