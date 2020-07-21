RMarkdown/Pandoc tables for word document output

# Adding styling rules for `.docx` output

Essentially, there are 4 steps that can go wrong:

- Wrong RMD (unlikely).
Differences in the initially generated DOCX.

- Differences in how the TableNormal style is saved in the DOCX.

- Differences in how the reference DOCX is used to format the final DOCX.

- I therefore suggest using the same minimal RMD posted above (full code on pastebin) to find out where the results start do differ:

I suppose the most likely culprits are the pandoc and the Office versions. Unfortunately, I cannot test other configurations at the moment. Now it would be interesting to see the following: For users where it does not work, what happens …

1. if you start from my initial.docx?

2. If that does not work, what if you use my reference.docx as reference document?

3. If nothing works, are there eye-catching differences in the generated XML files (inside the DOCX container)? 

With a number of users running these tests it should be possible to find out what is causing the problems. Here are a collection of files to test if you are having this issue.

## Solution modified from `stack

Active [1 year ago](https://stackoverflow.com/questions/17858598/?lastactivity "2019-01-19 22:18:50Z") [Viewed 11000 times 21](https://stackoverflow.com/posts/17858598/timeline "Timeline")

I'm have had the same question as this [thread of `stackflow`](https://stackoverflow.com/questions/17858598/add-styling-rules-in-pandoc-tables-for-odt-docx-output-table-borders) when I have needed to generate `odt/docx` reports via `markdown` using `knitr` and `pandoc` and am now wondering how you'd go about formating tables. 

Primarily I'm interested in adding rules (at least top, bottom and one below the header, but being able to add arbitrary ones inside the table would be nice too).

I've looked through the "styles" for the possibility of specifying table formating in a reference .docx/.odt.

The following additional formating is possible and here are some references however I still need more control over many aspects so this is how I have done it.

## Solutions

Here's how I searched how to do this:

The way to add a table in Docx is to use the `<w:tbl>` tag. So I searched for this in the github repository, and found it [in this file](https://github.com/jgm/pandoc/blob/7c980f39bf1cff941d3e78056fd69e0b371833e3/src/Text/Pandoc/Writers/Docx.hs) (called Writers/Docx.hs, so it's not a big surprise)

```
blockToOpenXML opts (Table caption aligns widths headers rows) = do
  let captionStr = stringify caption
  caption' <- if null caption
                 then return []
                 else withParaProp (pStyle "TableCaption")
                      $ blockToOpenXML opts (Para caption)
  let alignmentFor al = mknode "w:jc" [("w:val",alignmentToString al)] ()
  let cellToOpenXML (al, cell) = withParaProp (alignmentFor al)
                                    $ blocksToOpenXML opts cell
  headers' <- mapM cellToOpenXML $ zip aligns headers
  rows' <- mapM (\cells -> mapM cellToOpenXML $ zip aligns cells)
           $ rows
  let borderProps = mknode "w:tcPr" []
                    [ mknode "w:tcBorders" []
                      $ mknode "w:bottom" [("w:val","single")] ()
                    , mknode "w:vAlign" [("w:val","bottom")] () ]
  let mkcell border contents = mknode "w:tc" []
                            $ [ borderProps | border ] ++
                            if null contents
                               then [mknode "w:p" [] ()]
                               else contents
  let mkrow border cells = mknode "w:tr" [] $ map (mkcell border) cells
  let textwidth = 7920  -- 5.5 in in twips, 1/20 pt
  let mkgridcol w = mknode "w:gridCol"
                       [("w:w", show $ (floor (textwidth * w) :: Integer))] ()
  return $
    [ mknode "w:tbl" []
      ( mknode "w:tblPr" []
        ( [ mknode "w:tblStyle" [("w:val","TableNormal")] () ] ++
          [ mknode "w:tblCaption" [("w:val", captionStr)] ()
          | not (null caption) ] )
      : mknode "w:tblGrid" []
        (if all (==0) widths
            then []
            else map mkgridcol widths)
      : [ mkrow True headers' | not (all null headers) ] ++
      map (mkrow False) rows'
      )
    ] ++ caption'

```

I'm not familiar at all with Haskell, but I can see that the border-style is hardcoded, since there is no variable in it:

```
let borderProps = mknode "w:tcPr" []
                    [ mknode "w:tcBorders" []
                      $ mknode "w:bottom" [("w:val","single")] ()
                    , mknode "w:vAlign" [("w:val","bottom")] () ]

```

# What does that mean ?

That means that you can't change the style of the docx tables with the current version of PanDoc. Howewer, there's a way to get your own style.

# How to get your own style ?

1.  Create a Docx Document with the style you want on your table (by creating that table)
2.  Change the extension of that file and unzip it
3.  Open `word/document.xml` and search for the `<w:tbl>`
4.  Try to find out how your style translates in XML and change the borderProps according to what you see.

Here's a test with a border-style I created: <img width="676" height="177" src="../_resources/dd456ea67fac42a7b1ac74be23c8122b.png"/>

And here is the corresponding XML:

```
<w:tblBorders>
  <w:top w:val="dotted" w:sz="18" w:space="0" w:color="C0504D" w:themeColor="accent2"/>
  <w:left w:val="dotted" w:sz="18" w:space="0" w:color="C0504D" w:themeColor="accent2"/>
  <w:bottom w:val="dotted" w:sz="18" w:space="0" w:color="C0504D" w:themeColor="accent2"/>
  <w:right w:val="dotted" w:sz="18" w:space="0" w:color="C0504D" w:themeColor="accent2"/>
  <w:insideH w:val="dotted" w:sz="18" w:space="0" w:color="C0504D" w:themeColor="accent2"/>
  <w:insideV w:val="dotted" w:sz="18" w:space="0" w:color="C0504D" w:themeColor="accent2"/>
</w:tblBorders>

```

####  hack the xml content of converted docx. And the following is my R code for doing that.

The `tblPr` variable contains the definition of style to be added to the tables in docx. You could modify the string to satisfy your own need.

```
require(XML)

docx.file <- "report.docx"
tblPr <- '<w:tblPr xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:tblStyle w:val="a8"/><w:tblW w:w="0" w:type="auto"/><w:tblBorders><w:top w:val="single" w:sz="4" w:space="0" w:color="000000" w:themeColor="text1"/><w:left w:val="single" w:sz="4" w:space="0" w:color="000000" w:themeColor="text1"/><w:bottom w:val="single" w:sz="4" w:space="0" w:color="000000" w:themeColor="text1"/><w:right w:val="single" w:sz="4" w:space="0" w:color="000000" w:themeColor="text1"/><w:insideH w:val="single" w:sz="4" w:space="0" w:color="000000" w:themeColor="text1"/><w:insideV w:val="single" w:sz="4" w:space="0" w:color="000000" w:themeColor="text1"/></w:tblBorders><w:jc w:val="center"/></w:tblPr>'

## unzip the docx converted by Pandoc
system(paste("unzip", docx.file, "-d temp_dir"))
document.xml <- "temp_dir/word/document.xml"

doc <- xmlParse(document.xml)
tbl <- getNodeSet(xmlRoot(doc), "//w:tbl")
tblPr.node <- lapply(1:length(tbl), function (i)
                   xmlRoot(xmlParse(tblPr)))
added.Pr <- names(xmlChildren(tblPr.node[[1]]))
for (i in 1:length(tbl)) {
    tbl.node <- tbl[[i]]
    if ('tblPr' %in% names(xmlChildren(tbl.node))) {
        children.Pr <- xmlChildren(xmlChildren(tbl.node)$tblPr)
        for (j in length(added.Pr):1) {
            if (added.Pr[j] %in% names(children.Pr)) {
                replaceNodes(children.Pr[[added.Pr[j]]],
                             xmlChildren(tblPr.node[[i]])[[added.Pr[j]]])
            } else {
                ## first.child <- children.Pr[[1]]
                addSibling(children.Pr[['tblStyle']],
                           xmlChildren(tblPr.node[[i]])[[added.Pr[j]]],
                           after=TRUE)
            }
        }
    } else {
        addSibling(xmlChildren(tbl.node)[[1]], tblPr.node[[i]], after=FALSE)
    }
}

## save hacked xml back to docx
saveXML(doc, document.xml, indent = F)
setwd("temp_dir")
system(paste("zip -r ../", docx.file, " *", sep=""))
setwd("..")
system("rm -fr temp_dir")

```

When creating the docx, use a reference docx to get styles. That reference will contain a heap of other styles that just aren't used by Pandoc to create, but they are still in there. Typically you'll get the default sets, but you can add a new table style too.

Then, you only need to update the word\\document.xml file to reference the new table style, and you can do that programmatically (by unzipping, running sed, and updating the docx archive), eg:

```
7z.exe x mydoc.docx word\document.xml
sed "s/<w:tblStyle w:val=\"TableNormal\"/<w:tblStyle w:val=\"NewTableStyle\"/g" word\document.xml > word\document2.xml
copy word\document2.xml word\document.xml /y
7z.exe u mydoc.docx word\document.xml

```

- This answer combined with the --reference-docx= option is a killer!
- add a table style named "TableNormal" in reference.docx.


## What about odt ?

I didn't have a look at it yet, ask if you don't find by yourself using a similar method.


## Python

Using a reference docx file and then python-docx does the job pretty easily: [https://python-docx.readthedocs.io/](https://python-docx.readthedocs.io/). First convert your document to docx :

#### Bash script

```{bash}
pandoc 
    --standalone 
    --data-dir=/path/to/reference/ 
    --output=/tmp/xxx.docx input_file.md

```

#### Python script

```{python}
import docx

document = docx.Document('/tmp/xxx.docx')
for table in document.tables:
    table.style = document.styles['custom_style'] 

# custom_style must exist in your reference.docx file

```

#### Questions

*Is that package `pydocx` or `python-docx`? Does it work outside Windows? Where is the documentation for that class `docx.Document`?* **[TPPZ](https://stackoverflow.com/users/1264920/tppz)**
    
* that is `python-docx`. Yes it works outside windows. And there is the `docx.Document` documentation : [python-docx.readthedocs.io/en/latest/api/…](https://python-docx.readthedocs.io/en/latest/api/document.html#document-constructor) It still has some limitations though, but it's the most complete tool I've found to build docx files. 

Just add a table style what every you want called "Table" in the reference-doc file。And update pandoc to latest.