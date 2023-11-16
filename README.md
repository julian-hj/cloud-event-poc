# Cloud events on TAP POC

This POC sends cloud events to AMR on TAP (with an early build of 1.8) using a
tekton task invoked from a sample supplychain.

If you have targeted a full cluster you can also send some sample cloud events
with the bash script here.

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
