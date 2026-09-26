# Patroni PostgreSQL HA Failover Test

## Test Date

2026-09-24

## Cluster

- Patroni scope: `suta-ha001`
- PostgreSQL: 17.11
- DCS: 3-node etcd
- HAProxy: `db-router-1`
- PostgreSQL nodes:
  - `pg-ha-1` - `172.31.4.103`
  - `pg-ha-2` - `172.31.6.248`
  - `pg-ha-3` - `172.31.5.186`

## Test Objective

Verify that:

1. Patroni detects a failed PostgreSQL node.
2. A healthy replica is promoted to primary.
3. HAProxy follows the new primary automatically.
4. The failed node can rejoin the cluster as a replica.
5. Replication returns to zero lag.

## Test 1 — Controlled Patroni Failure

The original leader was:

```text
pg-ha-1
