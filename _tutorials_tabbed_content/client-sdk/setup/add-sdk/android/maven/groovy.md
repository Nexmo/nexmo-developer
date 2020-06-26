---
title: Groovy
language: groovy
---

```groovy
//...

allprojects {
    repositories {
        google()
        jcenter()
        maven {
            url "https://artifactory.ess-dev.com/artifactory/gradle-dev-local"
        }
        
    }
}
```
