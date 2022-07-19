# Helm

Note: Currently broken due to difficulty parsing the config.yaml as a volume

The HELM chart is supposed to assist in automating and templating your containerSSH deployment.

Check out the `values.yaml` to see what you can configure, you don't need to touch the templates.

Make sure to create the `containerssh-guests` and `containerssh` namespaces before running the helm install command.

If you're coming from the simple install, please uninstall this first.

`kubectl delete -f kubernetes.yaml`

`kubectl create ns containerssh-guests`
`kubectl create ns containerssh-guests`

```helm install -n containerssh containerssh ./containerssh -f ./containerssh/values.yaml --create-namespace --debug```
