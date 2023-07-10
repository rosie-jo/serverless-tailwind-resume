# serverless-tailwind-resume (cloud Resume Challenge) | https://rosie-jo.com/

## Architecture / overview

![IMG_1042](https://github.com/rosie-jo/serverless-tailwind-resume/assets/59978790/b4d2a16c-2aee-457e-b59e-0b52d901536a)


The point of this is to create a serverless personal website for the purpose of learning different devops methods and cloud resources, following the guidelines within [The Cloud Resume Challenge](https://cloudresumechallenge.dev/docs/the-challenge/). The diagram above shows the architecture; A user connects and is distributed the content via the aws cdn (cloudfront) and is delivered content from a bucket, as well as fetching data from dynamoDB which is triggered via a lambda function which is invoked upon a javascript call to the api which is all within the cdn delivered content - the diagram probably explains the flow better than my words do. 

## What is this ?

This is my attempt at the cloud resume challenge, completed in about 2 months part time and mostly 2-3 weeks full time (30-40 hours a week). 

### how did I about completing this, what decisions did I make ?

I've always had my heart set on learning AWS out of the main cloud providers, however to me it seemed working cloud agnosticly made sense in terms of IaC so I opted to use terraform. Eventhough I wanted to code this project out, I knew enough to know I couldn't begin with coding, so I built out the whole project clicking through the console to familarise myself with what I would need to know - from there I opened vscode and the docs and got programming !

## The repo begins with a full project ?

This repo does not contain the full challenge as I was working with two different domains and wanted to split the project up per domain, allowing me have two cleaner projects; however the other repo is not public as I did a lot of the development locally before implementing the ci/cd workflow.

## notable blockers

There was quite a few points within the project which kept me stuck for a week or so at a time, such as:
- blocking access to my s3 bucket without blocking cloudfront 
- validating (within terraform) the ssl certificate for cloudfront to use 
- using the boto3 library for python scripting (for the lambda function)
- pathing locally for the api gateway within terraform

  but I overcame all of these with enough research (and grit) !

## What would I improve upon if I was to take the challenge again ?

The challenge was all new to me, new methodologies, new technologies, new documentation, etc. If I was to complete the challenge again here's what I would improve:

- Begin with implementing the CI/CD workflow rather than finish with it
- Stop tinkering with AWS resources before terraform destroying.
- Begin with a TF remote state
- use a framework for the front end to begin with rather than pure html/css/js (settled on tailwind)
- Work with TF modules


