---
title: Security related websites
date: "2018-02-28"
publish: true
tags: ["websites", "security"]
---

## Resources

- [OWASP Cheatsheet](https://cheatsheetseries.owasp.org/)

## CTF

- [Github CTF Writeups](https://github.com/ctfs/) - CTF writups
- [CTF Time](https://ctftime.org/) - All about CTF competitions
- [Vulnhub](https://www.vulnhub.com/) - Vulnerable VMs for practice

## Auditing

- [Lynis](https://cisofy.com/lynis/) - A security auditing tool

## AJAX

### Don't

- Rely on client logic for security
- Build JSON dynamically
- Transmit secrets to the client
- Perform encryption on the client-side code
- Write your own serialization code (use `JSON` library)

### Do

- Keep business logic on the server
- Server - use CSRF tokens
- ALWAYS return JSON with an Object on the outside `{"object": "good code"}`

## Abuse Cases

Full [details here](https://cheatsheetseries.owasp.org/cheatsheets/Abuse_Case_Cheat_Sheet.html).

Create a speadsheet with the following tabs:

### Features

| Feature unique ID | Feature name          | Feature short description                     |
| ----------------- | --------------------- | --------------------------------------------- |
| FEATURE_001       | DocumentUploadFeature | Allow user to upload document along a message |

### Counter Measures

| Countermeasure unique ID | Countermeasure short description                       | Countermeasure help/hint                                |
| ------------------------ | ------------------------------------------------------ | ------------------------------------------------------- |
| DEFENSE_001              | Validate the uploaded file by loading it into a parser | Use advice from the OWASP Cheat Sheet about file upload |

### Abuse Cases

| Abuse case unique ID | Feature ID impacted | Abuse case's attack description                                         | Attack referential ID (if applicable) | CVSS V3 risk rating (score) | CVSS V3 string                               | Kind of abuse case | Countermeasure ID applicable | Handling decision (To Address or Risk Accepted) |
| -------------------- | ------------------- | ----------------------------------------------------------------------- | ------------------------------------- | --------------------------- | -------------------------------------------- | ------------------ | ---------------------------- | ----------------------------------------------- |
| ABUSE_CASE_001       | FEATURE_001         | Upload Office file with malicious macro in charge of dropping a malware | CAPEC-17                              | HIGH (7.7)                  | CVSS:3.0/AV:N/AC:H/PR:L/UI:R/S:C/C:N/I:H/A:H | Technical          | DEFENSE_001                  | To Address                                      |

## Access Control

