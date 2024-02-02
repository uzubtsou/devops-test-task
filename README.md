# CoffeeShop App ☕️

### Backend ReadMe - [click](backend/README.md)
### Fronted ReadMe - [click](frontend/README.md)

### How to run

> Terraform setup assumes everything is running locally, so terraform state is also stored locally, just for simplicity.

#### 1. Create a base minikube instance with terraform:
```shell
cd infra/terraform/base
terraform init
terraform apply -auto-approve
cd $(git rev-parse --show-toplevel)
```
```shell
# in case you running this on mac, run this command in another terminal
minikube tunnel
```
#### 2. Create a dev env:
```shell
cd infra/terraform/dev
terraform init
terraform apply -auto-approve
kubectl config set-context --current --namespace=develop
cd $(git rev-parse --show-toplevel)
```
##### 2.1 Fill the database
```shell
kubectl port-forward service/postgresql 5432:5432 -n develop
# kubectl port-forward does not return. To continue with the import, you will need to open another terminal.
```
```shell
cd backend
yarn install
yarn migrations:dev
yarn seeds:dev
```

#### 3. Create a prod env
```shell
cd infra/terraform/prod
terraform init
terraform apply -auto-approve
kubectl config set-context --current --namespace=prod
cd $(git rev-parse --show-toplevel)
```
##### 3.1 Fill the database
```shell
kubectl port-forward service/postgresql 5432:5432 -n prod
# kubectl port-forward does not return. To continue with the import, you will need to open another terminal.
```
```shell
cd backend
yarn build
yarn migrations:prod
yarn seeds:prod
```

#### _Have fun and awesome beans every day_ 🥳
