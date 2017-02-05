#!/bin/bash

sqlite3 `pwd`"/cards.sqlite" '.dump card' \
    | sed -e '/PRAGMA for/d' \
          -e '/BEGIN TRANS/d' \
          -e 's/INSERT INTO "card"/INSERT INTO z_decked_cards/g' \
          -e 's/CREATE TABLE card/DROP TABLE IF EXISTS z_decked_cards; CREATE TABLE z_decked_cards/g' \
          -e '/CREATE INDEX/d' \
          -e '/COMMIT/d' \
    > cards_dump.sql

cat ~/bin/dbd_postimport_queries.sql >> cards_dump.sql
