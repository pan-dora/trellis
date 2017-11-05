##DRUID 

## Create Supervisor Spec
```bash
curl -X POST -H 'Content-Type: application/json' -d @kafka-supervisor.json http://localhost:3001/druid/indexer/v1/supervisor
```
## Check Trellis-Event Status
`http://localhost:3001/druid/indexer/v1/supervisor/trellis-event/status`

## View the Overlord Console
`http://localhost:3001/console.html`