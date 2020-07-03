Document generation using Markdown and Pandoc - Gerard Braad's blog

[Gerard Braad's blog](http://gbraad.nl/blog/)

*   [About me](http://gbraad.nl/blog/category/about-me.html)
*   [Books](http://gbraad.nl/blog/category/books.html)
*   [CI / CD](http://gbraad.nl/blog/category/ci-cd.html)
*   [Containers](http://gbraad.nl/blog/category/containers.html)
*   [DevOps](http://gbraad.nl/blog/category/devops.html)
*   [High Availability](http://gbraad.nl/blog/category/high-availability.html)
*   [JavaScript](http://gbraad.nl/blog/category/javascript.html)
*   [Misc](http://gbraad.nl/blog/category/misc.html)
*   [OpenStack](http://gbraad.nl/blog/category/openstack.html)

# [Document generation using Markdown and Pandoc](http://gbraad.nl/blog/document-generation-using-markdown-and-pandoc.html "Permalink to Document generation using Markdown and Pandoc")

Date Tue 13 September 2016 Tags [markdown](http://gbraad.nl/blog/tag/markdown.html) / [documentation](http://gbraad.nl/blog/tag/documentation.html) / [pandoc](http://gbraad.nl/blog/tag/pandoc.html) / [docker](http://gbraad.nl/blog/tag/docker.html)

Maintaining documentation can be an involved process, especially when different versions and output formats are needed. One of the documents I, and probably you also, have to maintain is your work history or resume/CV. Some while back I changed this document from an OpenOffice document to plain text and ever since, this workflow has influenced how I deal with other documentation.

## Requirement and timeline

If I remember correctly the original version of my resume was written in Microsoft Word. As you can imagine, this limits the usage to Windows as the platform. Small corrections became unnecessarily difficult and painful. Of course I could use CrossOver Office or Wine and install Office 2003. But, this is never a long-term solution. So, I moved to OpenOffice as the `.odt` format looked promising. It was easy to use to generate the needed PDF output, but still... the workflow was far from ideal.

I wanted a workflow in which I can use just plaintext, which could be converted into the final format. Text is easy to index and to story under version management. This lead me to using XML directly and the use of FO (Formatting Objects), and Apache FOP. This was painful, but the results were decent to even very acceptable. It allowed me to describe elements with metadata, such as 'suffix', 'employment-type', etc. And all could be validated and transformed using XSLT. Although the conclusion was that the workflow was slow as there was no preview and transforming just took long. Also, describing elements was not useful as no-one would use the source material directly. Most recruiter use analysis tools that rely on extracting keywords and generate a profile based on this information. This can lead to incorrect results, but since they analyse hundreds of resumes this seems one of the best methods, besides being introduced by a reference.

I moved to a simpler approach which allows me to change the document and have a partial, and acceptable preview. By this time Markdown got more popular and I tried to convert my resume and it seemed like an acceptable approach. Using a standard parser the documents looked OK, but it missed the oomph. Then `pandoc` arrived and it changed everything.

## Markdown

Using Markdown I would be able to write the following

```

```

It will get rendered as follows:

![](../../_resources/df387a2de96149c4a7de0510cde28350.png)

This source is humanly readable, and can be parsed by something like the Webinterface of GitHub into a [decent representation](https://github.com/gbraad/resume/blob/master/resume.md). And when using [Markdown Preview](https://github.com/revolunet/sublimetext-markdown-preview) for Sublime Text, even editing this became a pleasure.

## Pandoc

Now for introducing [Pandoc](http://pandoc.org/). This tool is like a Swiss knife for handling documents. It can convert between different formats and allows you to specify a template for specific formats, such as HTML. This tool allows me to use:

```

```

This will generate a standard HTML output from `resume.md` as input. Headings are converted to `h6`, `h5`, etc. and links become `a`, etc.

## Styling and layout

But the beauty shows when a template is used:

```

```

This will generate a similar output, however the template refers to a stylesheet to style the look of the output. Using a template and stylesheet I am able to format the document to my liking. And since the output of markdown auto-generates names for elements in a consistent way, it is easy to style and format the document.

Take for instance the photo. Although I personally do not like photos on a resume, it is often requested. Placing it inline with the text does not look very nice.

![](../../_resources/7944ec688c8f4bd29be3fe0513da8d0c.png)

Using CSS it is possible to convert the following:

```

```

With the styling:

```

```

The output of this will look as follows:

![](../../_resources/d36c18d547fa4d21baa7387327347b81.png)

## Containerizing pandoc (software distribution)

Pandoc itself is written in Haskell. Although a nice language, it has a different style of programming. This means that few people can contribute, and a distribution like Fedora or Ubuntu can not always provide the latest version. This can be due to possible dependency issues, but also the effort a packager has to put into it. The developer of this tool only provides a .deb package. Since I mostly work on Fedora and CentOS, I had to find an alternative solution to install this tool.

This is a great use-case for a container, as it consolidates the dependencies of the tool, and will allow me to use the tool as packaged by the developer, on a distribution that would else not be supported. Because I use the provided package I can also file issues against a known version, which can aid in reproducibility.

This lead to me creating a container called `docugen`. It uses `pandoc`, `jekyll` and `pandoc-ruby` to integrate [Jekyll](https://jekyllrb.com/) with pandoc.

By setting an alias I can call `pandoc` as it is a local command, which actually calls the container:

```

```

You can find more information about it [here](https://hub.docker.com/r/gbraad/docugen/).

## Automated generation

Since creating the containerized version of Pandoc, it was easy to setup an automated process for generation of the resume output. Because I use GitLab for almost all of my projects I only needed to add a CI runner definition to my repository. Below is a snippet of the generation, which publishes to GitLab pages.

`.gitlab-ci.yml`

```

```

The result of my resume gets published on GitLab at [http://gbraad.gitlab.io/resume/](https://gbraad.gitlab.io/resume/) and syncs to GitHub, which hosts it at [https://gbraad.nl/resume](https://gbraad.nl/resume).

## PDF generation using Pandoc -> LaTeX

Pandoc can create nice looking PDF documents by using LaTeX. The handout of my [OpenStack Hands-on-Lab](https://gbraad.gitlab.io/openstack-handsonlabs/) was produced with this.

```

```

Although the results look really good, I had several issues with it:

*   increased the size of the docugen container by more than a gigabyte.
*   issues with properly rendering Chinese
    *   needed additional installation of modules and fonts
*   would not respect width and margins for pre-formatted blocks

Likely, all of them could be solved with some smart hacks, but I didn't have the time and interest to learn LaTeX. This felt to me like learning how to use XSLT to transform XML into something meaningful. I still have the packages installed in the container as some documents still use `xelatex` for the PDF generation.

## PDF generation using PhantomJS

To solve the issues mentioned above, I now use `phantomjs`. [PhantomJS](http://phantomjs.org/) is a headless browser based on the WebKit rendering engine, and is scriptable with JavaScript. By using this approach I am able to use a single stylesheet to produce the same output on screen as on paper.

```

```

To generate a PDF, I call:

```

```

## Page breaks

To produce a nicer result, I have also added the following to my stylesheet:

```

```

When printed this inserts a page break before the header starts. So when a new topic starts, but avoids it for the start of the document.

## Conclusion

Generating a document from plaintext using Markdown can be beneficial. The source will never suffer from issues with 'being unreadable' or 'deprecated software', and it can easily be indexed. Tracking changes and even publishing a change is not as easy as opening the file on my mobile phone, and commiting it using git. Automatically the result will be published.

I have moved all my documentation over to plaintext, from the handsonlabs, training and teaching material, schedules, etc. I am still tweaking some of the processes, but the convenience is that a single source material can be used for different outputs. For instance, I publish my articles of this [blog](http://gbraad.nl/blog/) in [Markdown](https://gitlab.com/gbraad/blog-content/blob/master/SUMMARY.md), as generated [documents](https://gbraad.gitlab.io/blog-content/), and as a [GitBook](https://gbraad.gitbooks.io/blog-articles/content/).

Do not settle for a solution forever. Over time requirements can change and new insights can be utilized to produce a better solution.

## Links

*   Source of my resume: [GitLab](https://gitlab.com/gbraad/resume/), [GitHub](https://github.com/gbraad/resume/)
*   [Published](https://gbraad.nl/resume/) version

## Endnotes

I looked for some of the older formats and output, but was unable to track them down. I do remember my businesscard was used as a reference for '[microformats](http://microformats.org/wiki/selected-test-cases-from-the-web)'. And someone tried to introduce an XML standard for resume, called xmlresume if I recall correctly. From experience I could conclude this would not work; no applicant will provide XML and converting it in a tool seems pointless.

At the moment I am still looking for a nice tool on Android to edit the documents. I use [SGit](https://github.com/sheimi/SGit) with [Writeily Pro](http://writeily.me/), but I am a little disappointed in both tools. Opening a file for viewing in sgit will modify the file, and it does not deal well with resetting this. And Writeily Pro becomes slow over time when editing a file. Closing it and re-opening solves this, but it breaks the writing streak. Sometimes I rather use [DroidEdit](http://www.droidedit.com/), as it is just a text editor and does not suffer from this issue. Tools on the iPad, like [Daedalus Touch](http://daedalusapp.com/) and [Textastic](https://textasticapp.com/) feel more productive. Suggestions are welcome...

* * *

## Comments

* * *

© 2016 Gerard Braad · Powered by [pelican-bootstrap3](https://github.com/getpelican/pelican-themes/tree/master/pelican-bootstrap3), [Pelican](http://docs.getpelican.com/), [Bootstrap](https://getbootstrap.com)

[Back to top](#)