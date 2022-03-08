- [ ] Validate Input
- [ ] We want to allow any postcode in an LSOA starting "Southwark" or "Lambeth" eg: SE1 7QD, SE1 7QA .
- [ ] We want to allow given postcodes even if they are not found.
  - [ ] We need to PostCodeFindere able to update the allowed postcode list
- [ ] Handle errors from the API
  - [ ] Retry Timeouts





    rescue StandardError => e
      PostcodeChecker.logger.error(
        "Unable to check LSOAChecker!" \
      )
      raise e
