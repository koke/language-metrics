# language-metrics

Generates language stats per version. All the hard work is done by GitHub's [linguist](https://github.com/github/linguist) gem and [libgit2](https://github.com/libgit2/rugged).

## Usage

Just call the `analyze.rb` passing the path to the repository you want to analyze.
The output will be a CSV of each tag with date and line count per language.

Note that it ignores tags that look like an alpha/beta release.

```./analyze.rb ~/code/wordpress-ios 
Version,Date,Objective-C,C++,HTML,C,Python,Shell,Ruby,JavaScript,PHP,Swift
1.0,2008-07-24,347600,791,2885,0,0,0,0,0,0,0
1.1,2008-07-31,349615,735,2860,0,0,0,0,0,0,0
1.2,2009-03-11,565697,0,2860,0,0,0,0,0,0,0
...
5.6,2015-09-15,3154877,0,5101,0,13000,7012,24622,12235,935,342610
5.6.1,2015-09-17,3155121,0,5101,0,13000,7012,24622,12235,935,342610
5.7,2015-11-16,3174886,0,5101,0,13000,7056,25063,12235,935,453769
```
