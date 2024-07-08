
# Install Reveal.JS

Full setup according to <https://revealjs.com/installation/>

I do this in a temporal directory

```bash
 git clone https://github.com/hakimel/reveal.js.git
 cd reveal.js && npm install
 npm start
```

I then modify the index.html file until satisfied. 

I then moved the `assets`, `css`, `dist`, `js` and `plugin` folder to my repo (I tried with a new branch). 

Does this work?

# Fonts/icons from many providers

## Fontsawesome
## Forkawesome

https://forkaweso.me/Fork-Awesome/

## Academicons

See instructions and code names at: 

https://jpswalsh.github.io/academicons/

I use the jsdelivr CDN to call the Academicons v1 (latest release in the 1.x.x range) from the content distribution network.

```{.html}
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/jpswalsh/academicons@1/css/academicons.min.css">
```

Call the icons using the `ai` prefix. For example:

```{.html}
<i class="ai ai-google-scholar-square ai-3x"></i>
```


# UNSW brand

I downloaded some backgrounds from 

https://www.unsw.edu.au/secure/brand