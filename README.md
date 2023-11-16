# Cloud events on TAP POC

This POC sends cloud events to AMR on TAP (with an early build of 1.8) using a
tekton task invoked from a sample supplychain. Apply all the yaml objects and 
provided that your TAP is correctly configured with a working my-apps workspace, 
you should see that the supply chain sends two cloud events to AMR (a location, 
and a "container" running at that location).

If you have targeted a full cluster you can also send some sample cloud events
with [the bash script here](send-location-event.sh).

You can see the container events in the GraphQL playground using the following
GraphQL query

```graphql
{
  containers(query: {location: {reference: "constellation"}} ) {
    pageInfo {
      startCursor
      endCursor
      hasNextPage
    }
    nodes {
      imageDigest
      imageURL
      state
      name
      correlationID
      location {
        reference
        labels {
          key
          value
        }
      }
    }
  }
}
```
