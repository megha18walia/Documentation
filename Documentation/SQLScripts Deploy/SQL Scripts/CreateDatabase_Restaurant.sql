  USE [master]
  GO
  IF NOT EXISTS (SELECT name FROM master.sys.databases WHERE name = N'Restaurant')
  CREATE DATABASE [Restaurant]
  GO







