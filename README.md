# Postcode Checker
To boot the application:
```
bundle install
be rackup
```

To test the application:
**Valid requests**
```
curl -X POST -d "postcode=SE1 7QD" localhost:9292/check_postcode
curl -X POST -d "postcode=SE17QD" localhost:9292/check_postcode
curl -X POST -d "postcode=SE1 7QA" localhost:9292/check_postcode
curl -X POST -d "postcode=SH24 1AA" localhost:9292/check_postcode
curl -X POST -d "postcode=SH24 1AB" localhost:9292/check_postcode
```

**Invalid requests**
```
curl -X POST -d "postcode=SE1 7Q" localhost:9292/check_postcode
curl -X POST -d "post=SE1 7Q" localhost:9292/check_postcode
curl -X POST -d "" localhost:9292/check_postcode
```

## Possible Improvements
- [ ] Handle HTTP errors from the API
  - [ ] Retry Timeouts
- [ ] Cache Requests Redis
- [ ] Create endoints to updated allowed list
  - [ ] Add authentication
  - [ ] Add DB storage
