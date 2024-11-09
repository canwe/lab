adx - addressbook.xml
adx is a minimalistic but massively web enabled address book running completely in web browser.  
Supported: Skype, Twitter, Flickr, Delicious, Facebook, LinkedIn, hCard (Microformats), instant messengers, etc.  
How it works: XML + XSLT = HTML in your web browser.  


Getting started with adx:
- Download and unzip latest adx_addressbook.xml_vX.XX.zip file from http://adx.elektronengehirn.net (hosted on SourceForge)
- Load addressbook.xml in a modern web browser (XSLT support is needed: tested in Firefox3+, Chrome/Chromium, Safari3+, Opera9+, IE6+)
- Click on a entry to show more details (e.g. address)
- Most entries in contact details are clickable (e.g. direct calling phone numbers via Skype, address lookup in Google Maps, etc.) 
- To add contacts just edit addressbook.xml in a text/xml editor of your choice.


Update from a previous version of adx:
Just replace the file 'adx2html_phonelist.xsl' with the new one from this release
        

Changes for version 0.78 (2010-05-23):
- enhancement: shadow for menu (can be enabled with XSLT variable 'menu_shadow'; by default disabled due to browser bugs, e.g. in Chromium)
- enhancement: transparency for menu (can be enabled with XSLT variable 'menu_opacity'; by default disabled due to issues in IE)
- enhancement: added footer anchor ( #footer )
- enhancement: clicking on a address to adds the information of the contact name in google maps 
- switched back to google maps as default map provider (bing does not officially support Opera). Adjustedable via variable 'map_href'
- bugfix: hCard entry 'fn' had the value of tag 'title' (if available). Fixed to 'forename' and 'surname' only.
- bugfix: issues on parsing birthday in hCard Microformat if value for variable 'birthday_outputFormat' was not 'YYYY-MM-DD'
- disabled url processing validator (due to false positives on import hCards contacts via http://adx.elektronengehirn.net/import/hcard2adx.php)
- adjusted url of twitter account (without leading 'www.')
Changelogs of older versions can be found in adx2html_phonelist.xsl


More infos:
http://adx.elektronengehirn.net