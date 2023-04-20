# pirate-code-3.0

[![Dart](https://github.com/PSDTools/app/actions/workflows/dart.yml/badge.svg?branch=main)](https://github.com/PSDTools/app/actions/workflows/dart.yml)
[![Netlify Status](https://api.netlify.com/api/v1/badges/25b0c44e-21b7-423c-a914-32aa4b23b708/deploy-status)](https://app.netlify.com/sites/pattonville-wallet/deploys)

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## C4 Diagram

```mermaid
C4Context
  title System Context diagram
  
  Enterprise_Boundary(b0, "Pattonville") {
    Person(customerA, "Admin", "A school/district admin, one who can can see trends as well as give tokens.")
    Person(customerB, "Teachers", "A teacher, the one giving tokens.")
    Person_Ext(customerC, "Stuco", "The ones removing tokens.")
    Person_Ext(customerD, "Student", "The ones using tokens.")
    Person_Ext(customerE, "Devs", "@PSDTools")


    %% System(SystemAA, "Internet Banking System", "Allows customers to view information about their bank accounts, and make payments.")

    %% Enterprise_Boundary(b1, "BankBoundary") {

      %% SystemDb_Ext(SystemE, "Mainframe Banking System", "Stores all of the core banking information about customers, accounts, transactions, etc.")

      %% System_Boundary(b2, "BankBoundary2") {
        %% System(SystemA, "Banking System A")
        %% System(SystemB, "Banking System B", "A system of the bank, with personal bank accounts. next line.")
      %% }

      %% System_Ext(SystemC, "E-mail system", "The internal Microsoft Exchange e-mail system.")
      %% SystemDb(SystemD, "Banking System D Database", "A system of the bank, with personal bank accounts.")

      %% Boundary(b3, "BankBoundary3", "boundary") {
        %% SystemQueue(SystemF, "Banking System F Queue", "A system of the bank.")
        %% SystemQueue_Ext(SystemG, "Banking System G Queue", "A system of the bank, with personal bank accounts.")
      %% }
    %% }

  }
  
  
  Enterprise_Boundary(b4, "Instructure") {
    Person(instructure, "Devs")
    
    System_Boundary(b5, "Canvas") {
      System(CanvasApp, "Canvas Application")
    }
  }


  %% BiRel(customerA, SystemAA, "Uses")
  Rel(instructure, CanvasApp, "Makes")
  %% BiRel(SystemAA, SystemE, "Uses")
  %% Rel(SystemAA, SystemC, "Sends e-mails", "SMTP")
  %% Rel(SystemC, customerA, "Sends e-mails to")

  %% UpdateElementStyle(customerA, $fontColor="red", $bgColor="grey", $borderColor="red")
  %% UpdateRelStyle(customerA, SystemAA, $textColor="blue", $lineColor="blue", $offsetX="5")
  %% UpdateRelStyle(SystemAA, SystemE, $textColor="blue", $lineColor="blue", $offsetY="-10")
  %% UpdateRelStyle(SystemAA, SystemC, $textColor="blue", $lineColor="blue", $offsetY="-40", $offsetX="-50")
  %% UpdateRelStyle(SystemC, customerA, $textColor="red", $lineColor="red", $offsetX="-50", $offsetY="20")

  %% UpdateLayoutConfig($c4ShapeInRow="3", $c4BoundaryInRow="1")
```
