# SH:24 Full Stack Engineer Tech Test

Thank you for applying to work with us. We ask all candidates to complete a coding test so we can fairly evaluate their technical capabilities.

Please treat this test as a real feature request and treat the work as if it were being used by real users.

We ask you to complete this test within a week. If you need more time, let us know and we can give you an extension. You will not be penalised for this.

There are no gotchas or trick questions in this test, we just want you to complete it based on the instructions provided. We don’t expect you to go beyond the instructions provided.

Feel free to get in touch and ask as many questions as you’d like.

# **Postcode Checker**

Your customer would like a simple web application to work out if a given postcode is within their service area.

Create a form where the input is a UK postcode. When submitting the form, the response should tell the user if the postcode is allowed or not. There’s no need to add any styling.

## **Requirements**

We are using the Postcodes.io REST API as our source for data. The service area is described by the following rules:

1. Postcodes are grouped into larger blocks called LSOAs. This is returned from the API when we query a postcode. We want to allow any postcode in an LSOA starting "Southwark" or "Lambeth". Example postcodes for these LSOAs are SE1 7QD and SE1 7QA respectively.
2. Some postcodes are unknown by the API or may be served despite being outside of the allowed LSOAs. We need to be able to allow these anyway, even though the API does not recognise them. SH24 1AA and SH24 1AB are both examples of unknown postcodes that we want to serve.
3. Any postcode not in the LSOA allowed list or the Postcode allowed list is not servable.

Please note that no guarantees about the format of the input can be given, and the allowed lists will need to be changed from time to time.

Documentation for the Postcodes.io API can be found at [http://postcodes.io](http://postcodes.io/)

For an example, you can either simulate the API on postcodes.io itself, or you could run:

```bash
curl [http://postcodes.io/postcodes/SE17QD](http://postcodes.io/postcodes/SE17QD)
```

This returns the following JSON:

```jsx
{
    "status":200,
    "result": {
        "postcode":"SE1 7QD",
         ...
         "lsoa":"Southwark 034A"
         ...
    }
}
```

# **Technology Choices**

Ruby is our go to language so if you’re a Ruby developer, or comfortable with Ruby, then please use it. However, if you’d rather use another language then please let us know since we’re more than open to discuss alternatives. Anything beyond this is up to you, feel free to use the tools that you are familiar with.

# **Coding Standards**

- Use git to version control the code
- Use a code formatter or linter
- Write end-to-end tests for the entire journey
- Write integration tests where applicable
- Write unit tests where applicable
- Include instructions in a README on how to run the application and how to run the tests

# **Submission**

Publish your code on GitHub and send us a link, or email us a zip file with the code.
