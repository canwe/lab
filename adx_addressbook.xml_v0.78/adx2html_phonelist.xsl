<?xml version="1.0"  encoding="ISO-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
				xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
				version="1.0">

<xsl:variable name="adxVersion">0.78</xsl:variable>

<rdf:Description rdf:about="http://adx.elektronengehirn.net" xmlns:cc="http://web.resource.org/cc/" xmlns:dc="http://purl.org/dc/elements/1.1/">
  <dc:title>Transforms addressbook to HTML phone list with embedded Microformats (vCard, XFN)</dc:title>
  <dc:date>2010-05-23</dc:date>  
  <dc:creator>Thomas Graf</dc:creator>
  <dc:creator>Thomas Bartensud</dc:creator>
  <dc:description>
This XSLT document transforms addressbook.xml to a list in HTML list with phone numbers. 
Following Microformats (machine readable semantic markup embedded in HTML) are supported by adx for every contact entry: 
- hCard (HTML vCard) including geo information
- XFN (XHTML Friends Network)
Microformats can be accessed and used for example by browser addons (like 'Operator' for Firefox).
More info: http://adx.elektronengehirn.net

Changelog:
0.78 (2010-05-23)
- enhancement: shadow for menu (can be enabled with XSLT variable 'menu_shadow'; by default disabled due to browser bugs, e.g. in Chromium)
- enhancement: transparency for menu (can be enabled with XSLT variable 'menu_opacity'; by default disabled due to issues in IE)
- enhancement: added footer anchor ( #footer )
- enhancement: clicking on a address to adds the information of the contact name in google maps 
- switched back to google maps as default map provider (bing does not officially support Opera). Adjustedable via variable 'map_href'
- bugfix: hCard entry 'fn' had the value of tag 'title' (if available). Fixed to 'forename' and 'surname' only.
- bugfix: issues on parsing birthday in hCard Microformat if value for variable 'birthday_outputFormat' was not 'YYYY-MM-DD'
- disabled url processing validator (due to false positives on import hCards contacts via http://adx.elektronengehirn.net/import/hcard2adx.php)
- adjusted url of twitter account (without leading 'www.')
0.77 (2010-02-13)
- enhancement: added account support (without icons) for rememberthemilk.com, ebay, huffduffer.com, gowilla.com, foursquare.com, wer-kennt-wen.de
- enhancement: improved support for defining an organization (use xml tag 'org' to define the organization name; no usage of 'surname', 'forename', 'middlename', 'surname' or 'title')
- enhancement: map application for showing postal address or geo location can now be configured (e.g. Bing or Google Maps; see variable 'map_href')
- enhancement: URL parameters can be used to overwrite settings defined in XSLT 
  example: addressbook.xml?showDetails=true, addressbook.xml?tagFilter=Musician, etc.
  in debug mode: see Link 'Save' to get the full URL 
- enhancement: changed microformat of tel number to value-class-pattern 
- enhancement: changed microformat of tel type to value-title-pattern
- enhancement: function toggleTag applies a tag now case insensitive
- fixed: html validation warning (HTML tags in javascript strings)
0.76 (2009-09-01)
- fixed created link for facebook account: http://www.facebook.com/{accountname}
  see http://sourceforge.net/apps/mediawiki/adx/index.php?title=Accounts#Facebook
- enhancement: added account support (without icons) for qype.com, brightkite.com, hi5.com, quarterlife.com, amiestreet.com, hellotxt
0.75 (2009-08-04)
- enhancement: tag engine - tag filtering works now completely case insensitive
- enhancement: tag engine - trimming/normalizing whitespaces for tags
- enhancement: tag engine - atomized tags
- enhancement: added account support (with icons) for identi.ca, bebo.com
- enhancement: added account support (without icons) for viadeo.com, 8tracks.com, studivz.net
- enhancement: added account support for lokalisten.de for public profiles (lokalisten-id has to be enabled)
- bugfix: Linked phonenr ('callto:') missed leading zero when variable 'phone_internationalAreaCode_default' was empty
- bugfix: IE8 had a javascript problem when an array definition has an additional comma after the last element
- known issue: Opera 9.27 omits sometimes(!) tags. Although combobox for tag filtering works correctly.
0.74 (2009-06-15)
- enhancement: straighten CSS for account icons (slightly decreaseed file size)
- enhancement: added support for The Hype Machine (hypem.com)
- enhancement: added support for orkut.com and friendster.com accounts (no icons yet)
- issue: replaced colored skype icon due to display problem in Safari 3.2.2 (http://sourceforge.net/apps/trac/adx/ticket/1)
0.73 (2009-06-12)
- enhancement: colored icons on mouseover
- enhancement: creating HTML document in standards-compliant mode (in order to avoid quirks mode in some browsers)
- enhancement: added adx favorite icon for browser address bar
- enhancement: added support for account technorati and my.opera.com (no icons yet)
- change: Minor GUI improvements by adjusting CSS
- bugfix: several minor bugfixes
0.72 (2009-06-07)
- bugfix: wrong image type in Base64 encoding for DeviantArt accounts
- enhancement: added support for account types vimeo.com, digg.com, dopplr.com (inclusive icons), lokalisten.de (no icons yet)
0.71 (2009-05-25)
- enhancement: XFN tags are now applied to links to websites, web accounts and and email addresses
- enhancement: added account support for ohloh.net, dopplr.com and cliqset.net (no icons yet)
- fixed: geo microformat with a non-empty attribute 'name' had no values for latitude and longitude
0.70 (2009-05-16)
- enhancement: Added tagging engine (assign tags to your contacts and filter contact display regardingly)
- enhancement: Adjusted xml structure of addressbook (not backward compatible!)
- enhancement: New supported account types (studiVZ, last.fm, Google, DeviantArt, SourceForge, spin.de)
- enhancement: Several GUI improvements
- enhancement: Improved support for french special characters
- bugfixes: several minor bugfixes
- renamed phone.xsl to adx2html_phonelist.xsl
0.59 (2009-03-01)
- added support for Internet Explorer 8 RC1 (finally MS added support for embedded images)
- added support for: LinkedIn, YouTube, Picasa and GoogleCode
- type attribute of account tag is evaluated case insensitive now
0.58 (2009-02-25)
- fixed menu toolbar
- added hide option for tag adx:frequency
- hCard: disabled attribute 'value' for 'tel' entries (improves compatibility with Firefox addin 'Operator')
- hCard: nickname is now also supported
- added tag 'middlename'
- fixed problem with Safari (account icons were hidden when no text in same line occured)
- switched to BSD license
0.57 (2009-02-19)
- added support for Flickr
- changed internal layout (table)
- added value 'none' for tag 'adx:frequency'
0.56 (2009-02-18)
- added support for Soup (http://soup.io)
- fixed hCard attribute for phone numbers (type 'mobile' is mapped now to official value for vCards: 'cell')
- fixed display of phone number icons in IE
0.55 (2009-02-17)
- improved birthday support
- birthday is now stored correctly in hCard microformat
- birthday output format can be adjusted in settings (see variable 'birthday_outputFormat', e.g. DD.MM.YYYY)
- Update instruction: birthday must be stored regarding ISO 8601 (YYYY-MM-DD)
0.54 (2009-02-16)
- added support for MySpace profile
- added support for Facebook profile
0.53 (2009-02-15)
- minor changes in examples for attributes 'use' and 'type' of phone
0.52 (2009-02-14)
- some fixes and changes
0.51 (2009-02-13)
- Fixed birthday highlighting bug
- Added field for state
- Added field for photo (not yet processed)
- Added possibility for tagging (folksonomy)
  </dc:description>
  <dc:rights>
Copyright (c) 2009, Thomas Graf
All rights reserved.

Redistribution and use in source and binary forms, with or without 
modification, are permitted provided that the following conditions are met:

o Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.
  
o Redistributions in binary form must reproduce the above copyright notice, 
  this list of conditions and the following disclaimer in the documentation 
  and/or other materials provided with the distribution.
  
o Neither the name of the elektronengehirn.net nor the names of its 
  contributors may be used to endorse or promote products derived from this 
  software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON 
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  </dc:rights>
  <cc:license rdf:resource="http://www.opensource.org/licenses/bsd-license.php"/>
</rdf:Description>

<xsl:output method="html" doctype-system="http://www.w3.org/TR/html4/strict.dtd" doctype-public="-//W3C//DTD HTML 4.01//EN" indent="yes"  encoding="ISO-8859-1"/>


<!-- User settings (please adjust) - START -->
<xsl:variable name="headline_show_default" select="true()"/><!-- possible values: true(), false() -->
<xsl:variable name="headline_text"><xsl:choose><xsl:when test="addressbook/@id"><xsl:value-of select="addressbook/@id"/></xsl:when><xsl:otherwise>addressbook.xml</xsl:otherwise></xsl:choose></xsl:variable><!-- you can adjust the headline here (e.g. Phonebook)  -->
<xsl:variable name="phone_showIcons" select="false()"/><!-- possible values: true(), false() -->
<xsl:variable name="phone_internationalAreaCode_default"><!--+49--></xsl:variable><!-- e.g. "+49" for germany; defines default international area code which is added if phone number starts with a zero, e.g. "0891234" becomes "+49891234"; normally the country you live-->
<xsl:variable name="accountIcons_colorStyle">grey</xsl:variable><!-- possible values: grey, color -->
<xsl:variable name="birthday_highlightUpcoming_default" select="true()"/><!-- possible values: true(), false() -->
<xsl:variable name="birthday_outputFormat">DD.MM.YYYY</xsl:variable><!-- Following tokens can be used: "YYYY", "MM", "DD" (e.g. YYYY-MM-DD, DD.MM.YYYY); Caution: the birthday in the input xml file must be always formatted as folowing: 'YYYY-MM-DD'  -->
<xsl:variable name="folksonomy_href"><!--http://delicious.com/tag/${tag}--><!--http://www.flickr.com/photos/tags/${tag}--><!--http://upcoming.yahoo.com/tag/${tag}--><!--http://technorati.com/tag/${tag}--><!--http://kitchen.technorati.com/contacts/tag/${tag}--><!--http://www.amazon.com/tag/${tag}--><!--http://yedda.com/questions/tags/${tag}--><!--http://www.youtube.com/results?search_query=${tag}--></xsl:variable> <!-- If not empty the folksonomy tags are linked to the given url, just uncomment one of the entries -->
<xsl:variable name="map_href">http://maps.google.com/maps?q=</xsl:variable> <!-- Defines URL for map application: e.g. 'http://www.bing.com/maps/default.aspx?q=' for Bing Maps or 'http://maps.google.com/maps?q=' for Google Maps-->
<xsl:variable name="details_show_default" select="false()"/><!-- possible values: true(), false() -->
<xsl:variable name="tag_adxFrequency_Show">high,medium</xsl:variable><!-- possible values: comma separated list of "high", "medium",  "low" (e.g. "high,medium")  -->
<xsl:variable name="menu_opacity">0.0</xsl:variable><!-- possible values: [0.0 .. 1.0], e.g. 0.9 means opacity of menu pane of 90%. 0 completely disables the opacity  -->
<xsl:variable name="menu_shadow" select="false()"/><!-- possible values: true(), false() -->

<xsl:variable name="debugMode" select="false()"/><!-- for developing purposes; possible values: true(), false() -->
<!-- User settings (please adjust) - END -->

<!-- 
Supported web browsers:
- basically all modern web browsers with support for XML/XSLT and JavaScript
- Opera (9 or newer)
  Tested versions: 9.27, 9.6, 10 (Windows), 10 (Linux)
- Firefox
  Tested versions: 3.0, 3.5, 3.6 (Windows, Linux)
- Safari
  Tested versions: 3.2.2 (Windows)
- Iron (Google Chrome)
  Tested versions: 3 (Windows), 4 (Linux)
- Internet Explorer
  Tested versions: 8 (limited support for version 6 and 7: text links instead of icons because embedded images are not suppported in IE 6 and 7)
-->











<!-- variables $lower and $upper are needed for providing primitive lower/uppercase functionality -->
<xsl:variable name="lower">abcdefghijklmnopqrstuvwxyzäöüâáàêéèëûúùîíìïôóòæçœÿ</xsl:variable> 
<xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜÂÁÀÊÉÈËÛÚÙÎÍÌÏÔÓÒÆÇŒŸ</xsl:variable>

<xsl:template name="stringReplace">
	<xsl:param name="text"/>
	<xsl:param name="replace"/>
	<xsl:param name="with"/>
	
	<xsl:choose>
		<xsl:when test="contains($text,$replace)">
			<xsl:value-of select="substring-before($text,$replace)"/>
			<xsl:value-of select="$with"/>
			<xsl:call-template name="stringReplace">
				<xsl:with-param name="text" select="substring-after($text,$replace)"/>
				<xsl:with-param name="replace" select="$replace"/>
				<xsl:with-param name="with" select="$with"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$text"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="buildId">
	<xsl:param name="prefix" select="''"/>
	<xsl:param name="suffix" select="''"/>
	
	<xsl:value-of select="$prefix"/><xsl:choose>
		<!--xsl:when test="starts-with(tag, 'adx:frequency=')"><xsl:value-of select="substring-after(tag, 'adx:frequency=')"/></xsl:when-->
		<xsl:when test="tag[starts-with(.,'adx:frequency=')]"><xsl:value-of select="substring-after(tag[starts-with(.,'adx:frequency=')], 'adx:frequency=')"/></xsl:when>
		<xsl:otherwise>na</xsl:otherwise>
	</xsl:choose>-<xsl:choose>
		<xsl:when test="nickname and not(nickname='')"><xsl:value-of select="nickname" />-</xsl:when>
		<xsl:when test="displayname and not(displayname='')"><xsl:value-of select="displayname" />-</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose><xsl:value-of select="forename" />-<xsl:value-of select="surname" />-<xsl:value-of select="birthday" />-<xsl:value-of select="@id"/><xsl:value-of select="$suffix"/>
</xsl:template>

<xsl:template name="buildAccountIcon">
	<xsl:param name="AlternativeDisplayName" select="''"/><!-- for IE 7  or older -->
	<xsl:param name="linkHref" select="''"/>
	<xsl:param name="linkTitle" select="$AlternativeDisplayName"/>
	<xsl:param name="cssClass" select="'surrogat'"/>

	<!-- Get XFN tag values (seems not possible to externalize in a template due to tree-fragment limitation for passing a node-set via xsl:param -->
	<xsl:variable name="_bAI_tagValues_temp">
		<xsl:for-each select="..//tag[starts-with(.,'xfn:rel=')]">
			<xsl:value-of select="substring-after(., 'xfn:rel=')"/><xsl:text> </xsl:text>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="bAI_tagValuesXFN" select="normalize-space($_bAI_tagValues_temp)"/>

	<a class="url">
		<xsl:attribute name="title"><xsl:value-of select="$linkTitle"/></xsl:attribute>
		<xsl:if test="string-length($bAI_tagValuesXFN) > 0">
			<xsl:attribute name="rel"><xsl:value-of select="$bAI_tagValuesXFN"/></xsl:attribute>
		</xsl:if>
		<xsl:if test="not($linkHref='')">
			<xsl:attribute name="href"><xsl:value-of select="$linkHref"/></xsl:attribute>
		</xsl:if>
		<span>
		  <xsl:attribute name="class">texticon_<xsl:value-of select="$accountIcons_colorStyle"/>IE icon_<xsl:value-of select="$cssClass"/>_<xsl:value-of select="$accountIcons_colorStyle"/>IE</xsl:attribute>
		  <xsl:value-of select="$AlternativeDisplayName"/>
		</span>
		<span>
		  <xsl:attribute name="class">icon icon_<xsl:value-of select="$cssClass"/>_<xsl:value-of select="$accountIcons_colorStyle"/></xsl:attribute>
		  <xsl:if test="$cssClass='surrogat'">
			<xsl:value-of select="$AlternativeDisplayName"/>
		  </xsl:if>
		</span>
	</a>
</xsl:template>


<xsl:template name="getTagValues">
	<xsl:param name="tags"/>
	
	<xsl:call-template name="stringReplace">
		<xsl:with-param name="text"><xsl:value-of select="$tags"/></xsl:with-param>
		<xsl:with-param name="replace" select="'xfn:rel='"/>
		<xsl:with-param name="with" select="''"/>
	</xsl:call-template>

	<!--
	<xsl:for-each select="$tags">
		<xsl:if test="contains(.,'=')">
			<xsl:value-of select="substring-after(., '=')"/>
		</xsl:if>
	</xsl:for-each>
	-->
</xsl:template>


	
<xsl:template match="/">
	<xsl:apply-templates select="*"/>
</xsl:template>


<xsl:template match="addressbook">
		<html>
		<head>
			<title><xsl:value-of select="$headline_text"/></title>
			<link href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAOdAAADnQBaySz1gAAABx0RVh0U29mdHdhcmUAQWRvYmUgRmlyZXdvcmtzIENTNAay06AAAAFuSURBVDiNpZMxaxwxEIU/hauCCTjBENgmlf9BwFXKdOpSuHOrH6HycKX+4KrAFduk2n4Lh8CFdaMr1+Wt74gIxiEYty9FdMt6iR3DDQhGT/PePGmQkcQ+8WIvNjD5z/l74AR4BfzO2Hfg8rkCJ8An4C3wI2O/hgJGkgXejYh3wEEmY4z5ACDpGjgHXmdHdxPgLJOOBgI/n3B1CiyBjwCklJoQggABcs6pbdsuhCDnnGKMAjpA3ntJ6iR13vu/HO+92raVpDal1AsBWi6X27Isx5jquhaguq47I6ldr9fHq9WKpmmYTqe9V0lfh2/gnGOz2QBQFAWz2eySbFHz+VxjB5IuJF0Mu+/yqqok6YvJAJKucrfjxxxYaymKonexWCyusdYKUErpQYfxfXcrxtjXlWXZEWNsrLWy1qqqqr4whCBr7QPRPIWtpO1uCkbS5+z48InZD+N2kB9OgG/APfDyH8U3wJvB/n5cYPb9zn8AhUf8frbvWpAAAAAASUVORK5CYII=" rel="shortcut icon" />
			<script type="text/javascript"> 
var debug = <xsl:choose>
	<xsl:when test="boolean($debugMode)=true()">true</xsl:when>
   	<xsl:otherwise>false</xsl:otherwise>
</xsl:choose>;

// fontsizes
var defaultSize=1.0; // should match with font-size value in css style for element TD
var min=0.1; 
var max=23.0; 

// birthday highlighting
var hilightBdaysEnabled = true; // type:bool, Turns complete highlighting of birthdays on/off
// settings for birthday highlighting
var maxDaysToBday              = 40; // type:int, disabled:0, enabled:>0
var extraHilightDaysAfterBday  = 0; // type:int, disabled:0, enabled:>0
var extraHilightDaysBeforeBday = 0; // type:int, disabled:0, enabled:>0

var detailsVisibility = <xsl:choose>
	<xsl:when test="$details_show_default">true</xsl:when>
   	<xsl:otherwise>false</xsl:otherwise>
</xsl:choose>;

var frequencies = Array("high", "medium", "", "low");
var frequencyLevel = "2";


var xfnDefinitions = {
	"relCategories" : [ {
			"name"   : "friendship",
			"values" : ["friend", "acquaintance", "contact"]
		}, {
			"name"   : "physical",
			"values" : ["met"]
		}, {
			"name"   : "professional",
			"values" : ["co-worker", "colleague"]
		}, {
			"name"   : "geographical",
			"values" : ["co-resident", "neighbor"]
		}, {
			"name"   : "family",
			"values" : ["child", "parent", "sibling", "spouse", "kin"]
		}, {
			"name"   : "romantic",
			"values" : ["muse", "crush", "date", "sweetheart"]
		}, {
			"name"   : "identity",
			"values" : ["me"]
		}
	]
};



String.prototype.trim = function() {
	// based on http://blog.stevenlevithan.com/archives/faster-trim-javascript ltrim12
	var	str = this.replace(/^\s\s*/, ''),
		ws = /\s/,
		i = str.length;
	while (ws.test(str.charAt(--i)));
	return str.slice(0, i + 1);
}
//alert("String.trim test: '" + " 1  2   3    4     ".trim() + "'");

String.prototype.removeAllWhitespaces = function() {
	return this.replace(/\s\s*/g, '');
}
//alert("String.removeAllWhitespaces test: '" + " 1  2   3    4     ".removeAllWhitespaces() + "'");

String.prototype.normalize = function() { // replaces n whitespaces (n>1) with one whitespace and removes trailing and leading whitespaces
	return this.replace(/\s\s*/g, ' ').trim();
}
//alert("String.normalize test: '" + " 1  2   3    4     ".normalize() + "'");


var vcardsHashtable = new Object();
var tagHashtable = new Object();

function _addToTagHashtable(tag, vCardId) {
	if (!tagHashtable[tag]) { 
		tagHashtable[tag] = new Array(); 
	}
	tagHashtable[tag].push( vcardsHashtable[vCardId] );
}

function addToTagHashtable(aTag, vCardId) {
	var tag = aTag.normalize();
	var normalizedTagArray = new Array();
	
	var splitIdx = tag.indexOf("=");
	var tagPrefix;
	var tagTokens;
	if (splitIdx >= 0) {
		tagPrefix = tag.substring(0, splitIdx + 1).removeAllWhitespaces(); // [tagNamespace:]tagName=, eg. "xfn:rel=" or "myTagNameWithVal="
	} else {
		splitIdx = tag.indexOf(":");
		if (splitIdx >= 0) {
			tagPrefix = tag.substring(0, splitIdx + 1).removeAllWhitespaces(); // [tagNamespace:]tagName, eg. "adx:testTag" or "myTagName"
		} else {
			tagPrefix = "";
		}
	}
	
	tagTokens = tag.substring(splitIdx+1).normalize().split(" ");	
	//alert("tagTokens-array(length=" + tagTokens.length + "): " + tagTokens);
	for (var i = 0; i &lt; tagTokens.length; i++) {
		var completeTag = tagPrefix + tagTokens[i];
		//alert("_addToTagHashtable(" + completeTag + ", " + vCardId + ")"	);		
		_addToTagHashtable(completeTag, vCardId);
		normalizedTagArray.push(completeTag);
	}	
	return normalizedTagArray;
}

function addTagsToTagHashtable(tagArray, vCardId) {
	var normalizedTagArray = new Array();
	for (var i=0; i &lt; tagArray.length; i++) {
		//var tmpAr = addToTagHashtable(tagArray[i], vCardId);
		//normalizedTagArray = normalizedTagArray.concat( tmpAr );
		normalizedTagArray = normalizedTagArray.concat( addToTagHashtable(tagArray[i], vCardId) );
	}
	return normalizedTagArray;
}

<xsl:for-each select="//contact">
	<xsl:variable name="vcardId"><xsl:call-template name="buildId"/></xsl:variable>
	vcardsHashtable["<xsl:value-of select="$vcardId"/>"] = {
		"id"  : "<xsl:value-of select="$vcardId"/>",
		"bday": "<xsl:value-of select="birthday" />",
		"tags": addTagsToTagHashtable([ <xsl:text/>
	<xsl:for-each select="tag[ (not(contains(.,'=')) and .!='')  or  (contains(.,'=') and substring-after(.,'=')!='')]">
		<xsl:text>"</xsl:text><xsl:value-of select="." /><xsl:text>"</xsl:text>
		<xsl:if test="not(position()=last())">, </xsl:if>
	</xsl:for-each>
	<xsl:text>], "</xsl:text><xsl:value-of select="$vcardId"/><xsl:text>")</xsl:text>
	};<xsl:text/>
	<!--xsl:for-each select="tag[ (not(contains(.,'=')) and .!='')  or  (contains(.,'=') and substring-after(.,'=')!='')]">
	addToTagHashtable("<xsl:value-of select="."/>", "<xsl:value-of select="$vcardId"/>" );<xsl:text/>
	</xsl:for-each-->
<xsl:text>
</xsl:text>	
</xsl:for-each>
 // vcard Hashtables

 
function vcardToString(vcard) {
	return "ID=" + vcard.id + ", bday=" + vcard.bday + ", Tags=" + vcard.tags;
}
/*
for (var i in vcardsHashtable) {
	alert( vcardToString(vcardsHashtable[i]));
	vcardsHashtable[i].bday = "foo";
	alert( vcardToString(vcardsHashtable[i]));
	for (var h in tagHashtable) {
		alert ( h + ":\n" + vcardToString(tagHashtable[h][0]) );
		break;
	}
	break;
}
*/
function getElById(objId) {
	if (document.all &amp;&amp; !document.getElementById) {
		return document.all(objId);
	} else {
		return document.getElementById(objId);
	}
}

function isElVisible(el) {
	return !(el.style.display == 'none');
}

function isElVisibleById(objId) {
	var el = getElById(objId);
	return isElVisible(el);
}


function setElVisibility(el, visible) {
	if (el == null) {
	  return;
	}
	if (visible==true) {
		el.style.display = '';
	} else {
		el.style.display = 'none';
	}
}

function setElVisibilityById(elId, visible) {
	var el = getElById(elId);
	setElVisibility(el, visible);
}

function hideEl(el) {
	setElVisibility(el, false);
}

function showEl(el) {
	setElVisibility(el, true);
}


function toggleElVisibility(el) {
    //alertNode(el);
	if (el == null) {
	  return;
	}
	if ( el.style.display != 'none' ) {
		setElVisibility(el, false);
	} else {
		setElVisibility(el, true);
	}
}

function toggleElVisibilityById(objId) {
	var el = getElById(objId);
	toggleElVisibility(el);
}

function toggleFreqMenuEntryStyleElById(objId) {
	var el = getElById(objId);
	//alert("el('" + objId + "').style.textDecoration: " + el.style.textDecoration);
	if(el.style.textDecoration == "underline")
		el.style.textDecoration = "none";
	else
		el.style.textDecoration = "underline";		
}



function dec2hex(dec) {
  hex="";
  do {
	rest=dec%16;
	switch(rest) {
		case 10: rest="A";
			break;
		case 11: rest="B";
			break;
		case 12: rest="C";
			break;
		case 13: rest="D";
			break;
		case 14: rest="E";
			break;
		case 15: rest="F";
			break;
	}
	hex=rest+""+hex;
	dec=Math.floor(dec/16);
  } while (dec>0);
  
  while (hex.length &lt; 2) { hex = "0"+hex; }
  
  return hex;
}

// returns fontsize as as a float or NULL if body.style.fontSize can not be read
// before first setting of element body.style.fontSize it seems that's always NULL!
function getFontSizeInEM() {
	var body = document.getElementsByTagName('body')[0]; 
	if (body.style.fontSize) { 
		//alert(body.style.fontSize);
		size = parseFloat(body.style.fontSize.replace("em",""));
		return size; 
	} 
	return null;
}

function setFontSize(newSize) {
	document.getElementsByTagName('body')[0].style.fontSize = newSize;
}

function setFontSizeInEM(newSize) {
	setFontSize(newSize + 'em');
}

function alterFontSize(growth) { 
	var size = getFontSizeInEM();
	//alert('current font size: ' + size);
	if (size == null) 
		size = defaultSize; 	
	var newSize = size + growth; 
	newSize = Math.min(newSize, max);
	newSize = Math.max(newSize, min);
	//alert("current size: " + size + "\nnew size: " + newSize);

	if (newSize != size) {
	  setFontSizeInEM(newSize); 
	}
} 

function increaseFontSize() { 
	alterFontSize(0.05);
} 

function decreaseFontSize() { 
	alterFontSize(-0.05);
} 




function getEl_VCard(vCardId) {
  var el = getElById(vCardId);
  if (el == null) {
    //alert("Element with id '" + vCardId + "' not found");
    return null;
  }
  return el;
}

function findElByClassName(rootEl, className) {
	if (rootEl==null) {
		return null;
	}	
	var rootElClassName = rootEl.className || rootEl.getAttribute("class"); // workaround due to getAttribute("class") does not work in IE (7 or older?)
	if (className == rootElClassName) {
		return rootEl;
	}
	
	var childElements = rootEl.childNodes;
	if (childElements == null)
		return null;
		
	for (var i=0; i &lt; childElements.length; i++) {
		if (childElements[i].nodeType == 1) {  // ignore all nodes which are not of type element
			var foundEl = findElByClassName(childElements[i], className);
			if (foundEl != null) {
				//alertNode(foundEl);
				return foundEl;
			}
		}
	}
	return null;
}

function getEl_VCardHeader(vCardId) {
  var el = getEl_VCard(vCardId);
  var foundEl = findElByClassName(el, "vCardHeader");
  //alertNode(foundEl);
  return foundEl;
}

function getEl_VCardDetails(vCardId) {
  var el = getEl_VCard(vCardId);
  var foundEl = findElByClassName(el, "vCardBodyLeft");
  //alertNode(foundEl);
  return foundEl;
}

function SetVCardDetailVisibility(vCardId, show) {
  var el = getEl_VCardDetails(vCardId);
  if (el == null) {
    return null;
  }
  
  if (show == true) {
    showEl(el);
  } else {
    hideEl(el);
  }
    
  //return true;
}

function toggleVCardDetailVisibility(vCardId) {
  var el = getEl_VCardDetails(vCardId);
  if (el == null) {
    return;
  }
  
  toggleElVisibility(el);
  //return true;
}

function SetAllVCardDetailVisibility(show) {
	detailsVisibility = show;
	for (var v in vcardsHashtable) {
		SetVCardDetailVisibility(vcardsHashtable[v].id, show);
	}
}

function toggleAllvCardVisibility() {
  SetAllVCardDetailVisibility(!detailsVisibility);
}

function alertNode(node) {
  var msg;
  if (node == null) {
    msg = "node is null";
  } else {
    msg  = node;
    msg += '\nnodeName=' + node.nodeName;
    msg += '\nnodeType=' + node.nodeType;
    msg += '\nnodeValue=' + node.nodeValue;
    msg += '\ndata=' + node.data;
    if (node.nodeType == 1) {
      msg += '\nAttributes';
      msg += '\n  class=' + node.getAttribute('class');
      msg += '\n  style=' + node.getAttribute('style');
    }
  }
  alert(msg);
}

function highlightUpcomingBirthdays() {
 if (!hilightBdaysEnabled) {
   return;
 }
   
 var today = new Date();
 for (var v in vcardsHashtable) {
   var vcard = vcardsHashtable[v];
   if (vcard.bday.length===0) {
     //alert("No birthday available for " +  vcard.id );
     continue;
   }

   if (vcard.bday == "YYYY-MM-DD") {
     //alert("Skip undefined birthday ('YYYY-DD-MM') for " +  vcard.id );
     continue;
   }

 
   // expected format: [[YYYY]-]DD-MM
   var bdayComponents = vcard.bday.split("-"); 
   if (bdayComponents.length &lt; 2) {
     //alert("splitting ('-') not possible: " + vcard.bday);
     continue;
   }

   day   = parseInt(bdayComponents[bdayComponents.length-1], 10);
   if (isNaN(day))
   {
	 //alert("Error for '" + vcard.id + "': day '" + bdayComponents[0] + "' is not a number!");
	 //continue;
	 day = today.getDay();
   }

   month = parseInt(bdayComponents[bdayComponents.length-2], 10);
   if (isNaN(month))
   {
	 //alert("Error for '" + vcard.id + "': month '" + bdayComponents[1] + "' is not a number (bday: '" + vcard.bday + "')!");
	 continue;
   }   
   month -= 1; // 0 = jan, 2 = feb, etc.
	 
   var daysLeft;
   var yearInc = 0;
   do {
	 bday = new Date(today.getFullYear() + yearInc, month, day, 0, 0, 0);
	 daysLeft = (bday - today) / (1000*60*60*24);
	 yearInc++;
   } while (daysLeft &lt; (-1 - extraHilightDaysAfterBday));
   
   if (maxDaysToBday>=0  &amp;&amp;  daysLeft &lt; maxDaysToBday) {   	 
	 // highlight Birthday

	 if (maxDaysToBday &lt;= 0) {
	   colorRed = "FF";
	 } else {
	   colorRed = dec2hex( Math.round( (maxDaysToBday-Math.max(0,daysLeft)) / maxDaysToBday * 255 ));
	 }
	 highlightColor = "#" + colorRed + "0000";
	 //alert(vcard.id + "Birthday\ndaysLeft: " + daysLeft + "\ncolor: " + highlightColor);
   
	 var el = getElById( vcard.id + "_birthday");
	 //alertNode(el);
	 if (el != null) {
	   //alert("" + vcard.id + " has birthday soon!");
	   el.style.color = highlightColor;
	 }
	 
	 // highlight name
	el = null;
	el = getEl_VCardHeader(vcard.id);
	if (el != null) {
	   //el = el.firstChild.firstChild;
	   
	   if (extraHilightDaysAfterBday>0  &amp;&amp;  daysLeft &lt; -(extraHilightDaysAfterBday+1)) {
		 //alert("no marking (birthday is too long in past)\n" + vcard.id + "\ndaysLeft: " + daysLeft);
	   } 
	   else if (daysLeft &lt; -1) {
		 //alert("marking for birthday in SHORT PAST\n" + vcard.id + "\ndaysLeft: " + daysLeft);
		 el.style.textDecoration = "line-through";
		 el.style.color = highlightColor;
	   } 
	   else if (daysLeft &lt; 0) {
		 //alert("highlight for TODAYs birthday\n" + vcard.id + "\ndaysLeft: " + daysLeft);
		 if (maxDaysToBday > 0) {
		   el.style.textDecoration = "underline";
		   //el.style.textDecoration = "blink";
		 }
		 el.style.color = highlightColor;
	   } 
	   else if (extraHilightDaysBeforeBday>0  &amp;&amp;  daysLeft &lt; extraHilightDaysBeforeBday) {
		 //alert("highlight for birthday in VERY NEAR FUTURE\n" + vcard.id + "\ndaysLeft: " + daysLeft);
		 el.style.textDecoration = "overline";
		 el.style.color = highlightColor;
	   } else {
		 //alert("highlight for birthday in NEAR FUTURE\n" + vcard.id + "\ndaysLeft: " + daysLeft);
		 el.style.color = highlightColor;
	   }
	   
	   //el.style.fontSize = Math.max(defaultSize, (maxDaysToBday-daysLeft)/maxDaysToBday * defaultSize*2 ) + "px";
	 }
   } else {
		//alert(vcard.id + ": " + vcard.bday + "\nmaxDaysToBday: " + maxDaysToBday + "\ndaysLeft: " + daysLeft + "\nmaxDaysToBday: " + maxDaysToBday);
   }   
 }
 //alert("Finished function 'highlightUpcomingBirthdays()'");
}

/* 
 ************************* section for tag handling *************************
 */
var TAGFINDER_REGEX_PREFIX = "regex:";

function writeTagCloud() { // still necessary????????????
    var br = "&lt;br>";
	var s = br;
	for (var v in tagHashtable) {
		s += "&lt;a href=\"#\" onClick=\"applyTagFilter('" + v + "')\">" + v + "&lt;\/a>(" + tagHashtable[v].length + ") " + br;
	}	
	s += "&lt;a href=\"#\" onClick=\"resetTagFilter()\">Reset tag filter&lt;\/a>" + br;
	getElById("tagCloud").innerHTML = s;
}

function writeTagDropDownBox(elId) {
	var s = "";
	s += "&lt;select name=\"tagMenu\" style=\"width: 10em\" onChange=\"applyTagFilter(this.options[this.selectedIndex].value)\">";
	for (var tag in tagHashtable) {
		s += "&lt;option value=\"" + tag + "\">" + tag + "&lt;\/option>";
	}
	s += "&lt;\/select>";
	getElById(elId).innerHTML = s;
}

function caseInsensitiveStringSort(a, b) {
	var aLower = a.toLowerCase();
	var bLower = b.toLowerCase();
	if (aLower == bLower) {
		return 0;
	} else 	if (aLower &lt; bLower) {
		return -1;
	} else {
		return 1;
	}
}

function fillTagDropDownBox(elId) {
	var select = getElById(elId);
	if (select.length > 0) select.length=0;
	select.options[0] = new Option("&lt;None>", "");
	
	var tags = new Array();
	var tagFinders = new Object();
	for (var tag in tagHashtable) { // add all actually used tags
		if ( tag.indexOf("adx:frequency=") &lt; 0) {
			tags[tags.length] = tag;
			tagFinders[tag] = tag;
		}
	}

	// add only XFN relationship categories whose values are actually used in address book
	var xfnTags = new Array(); // contains only xfn tags actually used in address book (for performance reasons)
	for (var x=0; x &lt; tags.length; x++) {
		var tagLower = tags[x].toLowerCase();
		if (tagLower.indexOf("xfn:rel=") == 0)
			xfnTags[xfnTags.length] = tagLower;
	}
	//alert("xfnTags.length=" + xfnTags.length);
	for (var i=0; i &lt; xfnDefinitions.relCategories.length; i++) {
		var relCategory = xfnDefinitions.relCategories[i];
		var foundCategory = false;
		for (var j=0; j &lt; relCategory.values.length &amp;&amp; !foundCategory; j++) {
			//var relCategoryValue = relCategory.values[j];
			var regexCategoryValue  =  new RegExp("\\b" +  relCategory.values[j] + "\\b", "i");
			for (var x=0; x &lt; xfnTags.length &amp;&amp; !foundCategory; x++) {
				/*
				if (xfnTags[x].indexOf(relCategoryValue) >= 0) {
					if (relCategoryValue == "me") { // avoid finding "met" when searching for "me"
						var tmpXfnTag = xfnTags[x] + " ";
						//alert("tmpXfnTag= '" + tmpXfnTag + "' (temporary changed)\nxfnTags[" + x + "]= '" + xfnTags[x] + "' (must be unchanged)");
						if (tmpXfnTag.indexOf("me ") &lt; 0) {
							//alert("continue");
							continue;
						}
					}
					//select.options[select.options.length] = new Option("xfn:rel=*(" + relCategory.name + ")", "xfn:rel=*(" + relCategory.name + ")");
					tags[tags.length] = "xfn:rel=*(" + relCategory.name + ")";
					//alert(select.options[select.options.length-1]);
					foundCategory = true;
				}
				*/
				if (regexCategoryValue.test(xfnTags[x])) {
					var dropDownBoxEntry = "xfn:rel=*(" + relCategory.name + ")"
					tags[tags.length] = dropDownBoxEntry;
					var regexFilter = "regex:^xfn:rel=.*\\b(";
					for (var n=0; n &lt; relCategory.values.length; n++) {
						regexFilter += (n==0?"":"|") + relCategory.values[n];
					}
					regexFilter += ")\\b";
					tagFinders[dropDownBoxEntry] = regexFilter;
					//alert(select.options[select.options.length-1]);
					foundCategory = true;
				}
			}
		}		
	}
	
	//alert (tags);
	tags.sort(caseInsensitiveStringSort);
	//alert (tags);
	for (var i=0; i &lt; tags.length; i++) {
		select.options[select.options.length] = new Option(tags[i], tagFinders[tags[i]]);
	}
	/*
	select.options[select.options.length] = new Option("re:me", "regex:^xfn:rel=.*\\bme\\b");
	select.options[select.options.length] = new Option("re:familyXfnRelW1", "regex:^xfn:rel=.*\\b(child|parent|sibling|spouse|kin)\\b");
	select.options[select.options.length] = new Option("re:familyXfnRelWAll", "regex:^xfn:rel=.*(\\bchild\\b|\\bparent\\b|\\bsibling\\b|\\bspouse\\b|\\bkin\\b)");
	select.options[select.options.length] = new Option("re:familyWAll", "regex:\\bchild\\b|\\bparent\\b|\\bsibling\\b|\\bspouse\\b|\\bkin\\b");
	select.options[select.options.length] = new Option("re:family", "regex:child|parent|sibling|spouse|kin");
	*/
}




function applyTagFilter(tag) {
    //alert("Entering function applyTagFilter(tag = '" + tag + "')");
    if (tag==null || tag.length==0) {
	    //alert("Show all Entries");
		resetTagFilter();
	} else if (tag.indexOf(TAGFINDER_REGEX_PREFIX) == 0) {
		var regexTag = new RegExp(tag.substr(TAGFINDER_REGEX_PREFIX.length), "i");
		//alert("regexTag='" + regexTag + "'");
		for (var vcId in vcardsHashtable) {
			var show = false;
			var tagArray = vcardsHashtable[vcId].tags;
			//alert(tagArray);
			for (var i=0; i &lt; tagArray.length; i++) {
				if (regexTag.test(tagArray[i])) {
					//alert("found tag '" + tag + "' in vCard: " + vcId);
					show = true;
					break;
				}
			}
			setElVisibilityById(vcId, show);
		}		
		getElById("tagDropDownBox").options[0].text = "&lt;None>";
	} else {
		//alert(tag);
		var tagLower = tag.toLowerCase();
		for (var vcId in vcardsHashtable) {
			var show = false;
			var tagArray = vcardsHashtable[vcId].tags;
			//alert(tagArray);
			for (var i=0; i &lt; tagArray.length; i++) {
				if (tagLower == tagArray[i].toLowerCase()) {
					//alert("found tag '" + tag + "' in vCard: " + vcId);
					show = true;
					break;
				}
			}
			setElVisibilityById(vcId, show);
		}
		getElById("tagDropDownBox").options[0].text = "&lt;None>";
	}
}

function resetTagFilter() {
	for (var vcId in vcardsHashtable) {
		setElVisibilityById(vcId, true);
	}
	getElById("tagDropDownBox").options[0].text = "&lt;None>";
}

function getSelectedTag() {	
	var select = getElById("tagDropDownBox");
	var tag = select.options[select.options.selectedIndex].text;
	if (tag=='&lt;None>' || tag=='')
		return null;
	return tag;
}

// must match with text value in dropdown box (not with _value_ behind the entry in dropdown box)
function toggleTag(tag) {
	//alert("Entering function toggleTag( tag='" + tag + "' )");
	var tagLower = tag.toLowerCase();
	var select = getElById("tagDropDownBox");
	for (var i=0; i &lt; select.options.length; i++) {
		if (tagLower == select.options[i].text.toLowerCase()) {
			if (i == select.options.selectedIndex) {
				select.options.selectedIndex = 0; // deselect tag
			} else {
				select.options.selectedIndex = i;
			}
			applyTagFilter(select.options[select.options.selectedIndex].value);			
		}
	}
}

function applyTagsToUserDetails() {
	for (var vcardId in vcardsHashtable) {
		var tagGroupEl = document.getElementById(vcardId + '_tagGroup');
		if (tagGroupEl != null) {
			var vcard = vcardsHashtable[vcardId];
			var tagCount = vcard.tags.length;			
			for (var i=0; i &lt; tagCount; i++) {
			    var tag = vcard.tags[i];
				if (tag!=""  &amp;&amp;  tag.indexOf("adx:")&lt;0  &amp;&amp;  (tag.indexOf("=")&lt;0 || tag.substr(tag.indexOf("=")).length>0)) {
					var newAEl = document.createElement("a");

					newAEl.setAttribute("class", "tag");
					newAEl.setAttribute("className", "tag"); // IE6 issue workaround for 'class' assignment
					//newAEl.className = "tag" ; // may be needed for IE7 (untested)
					newAEl.setAttribute("rel", "tag");
					newAEl.setAttribute("href", "http://adx.elektronengehirn.net/tags/" + tag ); // pseudo link in order to get Firefox plugin operator (0.9.3) working (if href="#", the tag is not recognized correctly)
					newAEl.setAttribute("title", tag.indexOf("xfn:")==0 ? "XFN tag (XHTML Friends Network relationship)" : "Tag");
					//newAEl.setAttribute("onClick", "toggleTag('" + tag + "');return false;"); // return false needed for Opera 9.27 (otherwise page is reloaded; returning false in function didn't work!?)
					newAEl['onclick'] = new Function("toggleTag('" + tag + "');return false;");
					//newAEl.innerHTML = tag;
					newAEl.appendChild( document.createTextNode(tag) );

					tagGroupEl.appendChild(newAEl);
				}
			}
		}
	}
}

function isTrue(o) {
	if (o==1)
		return true;
		
	var oLower = o.toLowerCase();
	if (oLower=="true" || oLower=="yes" || oLower=="y")
		return true;
	
	return false;
}

function isFalse(o) {
	if (o==0)
		return true;
		
	var oLower = o.toLowerCase();
	if (oLower=="false" || oLower=="no" || oLower=="n")
		return true;
	
	return false;
}

function evalBool(o) {
	if (isTrue(o)) return true;
	if (isFalse(o)) return false;
	return null; // o could not be evaluated as a valid bool value
}

function executeCommand(cmd, param) {
	//alert("Entering function executeCommand(cmd='" + cmd + "', param='" + param + "')");
	cmd = cmd.toLowerCase();
	switch (cmd) {
		case "showdetails":
		case "details":
			// set details visibility only if param can be evalutated to TRUE/FALSE (actual showing/hiding of element is done in onBodyLoad)
			var paramBool = evalBool(param);
			//alert("executeCommand(cmd='" + cmd + "', param='" + param + "') -> paramBool=" + paramBool);
			if (paramBool == null)
				return false; // error: param could not be evaluated to boolean
			detailsVisibility = paramBool;
			return true;

		case "showheader":
		case "header":
			var paramBool = evalBool(param);
			//alert("executeCommand(cmd='" + cmd + "', param='" + param + "') -> paramBool=" + paramBool);
			if (paramBool == null)
				return false; // error: param could not be evaluated to boolean
			setElVisibilityById("Header", paramBool);
			return true;

		case "tagfilter":
		case "tag":
			//alert("executeCommand(cmd='" + cmd + "', param='" + param + "'");
			if (param == "")
				return true;
			toggleTag(param);
			return true; // warning: a not existing tag value also returns true!

		case "fontsize":
			// todo: add possibility to define size directly (in 'em')
			setFontSize(param);
			return true;

		case "showfrequencyhigh":
		case "frequencyhigh":
			var paramBool = evalBool(param);
			//alert("executeCommand(cmd='" + cmd + "', param='" + param + "') -> paramBool=" + paramBool);
			if (paramBool == null)
				return false; 
			setElVisibilityById('adx:frequency=high', paramBool);
			return true;

		case "showfrequencymedium":
		case "frequencymedium":
			var paramBool = evalBool(param);
			//alert("executeCommand(cmd='" + cmd + "', param='" + param + "') -> paramBool=" + paramBool);
			if (paramBool == null)
				return false; 
			setElVisibilityById('adx:frequency=medium', paramBool);
			return true;

		case "showfrequencylow":
		case "frequencylow":
			var paramBool = evalBool(param);
			//alert("executeCommand(cmd='" + cmd + "', param='" + param + "') -> paramBool=" + paramBool);
			if (paramBool == null)
				return false; 
			setElVisibilityById('adx:frequency=low', paramBool);
			return true;
			
		// ignored commands (may come from online transformation)
		case "xml":
		case "xsl":
			return true;

		default:
			//alert("unknown command: '" + cmd + "' (param='" + param + "')");
			return false;
	}
}
function getAdxSettingsAsURL() {
	var urlParts = window.location.href.split("#");
	var anchor = urlParts.length > 1 ? urlParts[1] : "";
	var url = urlParts[0].split("?")[0] + "?"; // remove params from url
	url += "showdetails=" + (detailsVisibility?"1":"0");
	url += "&amp;showheader=" + (isElVisibleById('Header')?"1":"0");
	var tag = getSelectedTag();
	if (tag != null)
		url += "&amp;tagfilter=" + tag;
	url += "&amp;frequencyhigh=" + (isElVisibleById('adx:frequency=high')?"1":"0");
	url += "&amp;frequencymedium=" + (isElVisibleById('adx:frequency=medium')?"1":"0");
	url += "&amp;frequencylow=" + (isElVisibleById('adx:frequency=low')?"1":"0");
	
	var fontSize = getFontSizeInEM();
	if (fontSize != null)
		url += "&amp;fontsize=" + fontSize + "em";
	if (anchor != "")
		url += "#" + anchor;
	return url;
}

function saveAdxSettingsButton_OnClick() {
	var url = getAdxSettingsAsURL();
	if (url) {
		var msg = "Apply current adx settings to browser URL \n(e.g. for bookmarking adx with a certain tag filter)."
		if (debug) {
			msg += "\n\nFollowing parameters are used:\n * ";
			var urlParts = url.split("#");
			var urlHash = urlParts.length > 1 ? urlParts[1] : "";
			var urlParams =urlParts[0].split("?")[1]; // get URL parameters
			msg += urlParams.replace(/&amp;/g, "\n * ");
			if (urlHash != "") {
				msg += "\n * Hash: #"+ urlHash;
			}
		}
		alert(msg);
		window.location.href = url;
	}
}

function processURLParameters() {
	//alert("Entering function processURLParameter()");
	var processingOfAllURLParamsSucceeded = true;
	if (window.location.search == "")
		return processingOfAllURLParamsSucceeded;
		
	var urlParam = window.location.search;
	//alert(urlParam);
	while (urlParam[0] == "?")
		urlParam = urlParam.substr(1); // removes leading question mark
	//alert("processURLParameter(): urlParam='" + urlParam + "'");

	var actions = urlParam.split("&amp;");
	//alert("actions= {" + actions + "}");
	for (i=0; i&lt;actions.length; i++) {
		var actionAr = actions[i].split("=");
		var cmd = actionAr[0];
		var cmdParam = "";
		if (actionAr.length>1) {
			cmdParam = actionAr[1];
			for (var j=2; j&lt;actionAr.length; j++) // recreates param value if '=' is/are contained
				cmdParam += "=" + actionAr[j];
		}
		
		//alert("action= {" + actionAr + "}");		
		if (!executeCommand(cmd, cmdParam)) {// todo: trim param?, unescape param?
			processingOfAllURLParamsSucceeded = false;
			<xsl:if test="boolean($debugMode)=true()">
			//alert("URL processing failed for param: '" + actions[i]  + "' (all URL params: '" + window.location.search + "')");
			</xsl:if>			
		}
	}
	return processingOfAllURLParamsSucceeded;
}




function onBodyLoad() {
	<xsl:if test="boolean($birthday_highlightUpcoming_default)=true()"> 
	highlightUpcomingBirthdays();
	</xsl:if>
	
	applyTagsToUserDetails();
	fillTagDropDownBox("tagDropDownBox");
	
	processURLParameters();
	
	if (detailsVisibility) {
		SetAllVCardDetailVisibility(detailsVisibility);
	}
	//alert("vcards(" + vcards.length + "): \n[0]" + "\nid: " + vcards[0].id + "\ntags(" + vcards[0].tags.length + "): " +  vcards[0].tags.toString());
	//writeTagCloud();
	//writeTagDropDownBox("tagDropDownBox");
	//setElVisibilityById("tagCloud", true);
	//alert("show tag cloud");
	
	// Init menu frequency: markers for visibility of the frequency levels
	if (isElVisibleById('adx:frequency=high'))
		toggleFreqMenuEntryStyleElById('MenuFreqHi');
	if (isElVisibleById('adx:frequency=medium'))
		toggleFreqMenuEntryStyleElById('MenuFreqMed');
	if (isElVisibleById('adx:frequency=low'))
		toggleFreqMenuEntryStyleElById('MenuFreqLo');
		
	//window.alert("Diese Datei: " + document.URL);
	//if (window.location.search != "") alert(window.location.search);
}

</script>

<style type="text/css">
	body { 
		font-family:Tahoma; 
		font-size: 1em; 
		margin-top:0px }
	TD { 	font-family:Verdana,Tahoma; font-size:0.75em; vertical-align:top; } 
	.colName { 	
		font-family:Georgia,serif; text-align:right; vertical-align:top; 
		padding-right: 4px;
		margin-right: 3px; 
		margin-bottom: 7px;
		/*border-right:1px solid #FFCC99;*/
	}
	abbr {
		border: none;
	}

	.vCardBodyRight{ 	
		font-family:Georgia,serif; text-align:left; vertical-align:top; 
		padding-left: 2px; 
		margin-left: 0px; 
		margin-bottom: 7px;
	}
	
	.tdVerticalSeparator  { 
		font-size: xx-small;
		border-left: 1px solid #666666; 
		padding-left:0px; 
		padding-right: 0px;
		margin-right: 0px; 
	}
	
	#tagCloud {
		/*
		display: none;
		*/
	}

	
	body > #menu {
		position: fixed;
	}

	.menu {
		position: absolute; 
		top: 0px; 
		left: 0px; 
		width: 100%;
		z-index: 99;
		color: #999999;
		padding-top: 1px;
		padding-bottom: 2px;
		border-bottom: 1px solid #999; 
		background-color: #F6F6F6;
	<xsl:if test="boolean($menu_shadow)=true()">

		/* shadow */
		<!--
		-ms-filter: "progid:DXImageTransform.Microsoft.Shadow(color=#666666,direction=180,strength=4)"; /* IE8+ */  
		filter: progid:DXImageTransform.Microsoft.Shadow(color=#666666,direction=180,strength=4); /* IE7 and lower */  
		-->
		box-shadow:0px 1px 4px #666;
		-moz-box-shadow:0px 1px 4px #666;
		-webkit-box-shadow: 0px 1px 4px #666;  
		-ms-filter: "progid:DXImageTransform.Microsoft.Shadow(color=#666666,direction=180,strength=4)"; /* IE8+ */  
	</xsl:if>
	<xsl:if test="$menu_opacity > 0">

		/* opacity */
		<!--
		-ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=<xsl:value-of select="$menu_opacity * 10"/>)"; /* for IE8 */
		filter: alpha(opacity=<xsl:value-of select="$menu_opacity * 10"/>);  /* for IE 7 and older */
		/* order of ie filter matters */
		-->
		-ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=<xsl:value-of select="$menu_opacity * 10"/>)"; /* for IE8 */
		-khtml-opacity: <xsl:value-of select="$menu_opacity"/>;
		-moz-opacity: <xsl:value-of select="$menu_opacity"/>;
		opacity: <xsl:value-of select="$menu_opacity"/>;
	</xsl:if>
	}

	.menuLeft {
		text-align: left;
		float: left;
		margin-right: 3px;
		margin-top: 2px; /* workaround for vertical centerign  */
		margin-left: -4px;
	}
	.menuRight {
		text-align: right;
		float: right;
		margin-right: 3px;
	}
	
	select { 
		font-family:Tahoma; 
		font-size:0.9em; 
		width: 10em;
		margin-bottom: 0px;
	}

	#main {
		margin-top: 40px;
		margin-bottom: 23px;
		margin-right: auto;
		margin-left: auto;
	}

	h1,th { 	font-family:serif; text-align:left; font-style:italic; font-size:2em; }
	
	.menu { 	font-family:Tahoma; font-size:11px; color:#666666; text-align:right; vertical-align:top; margin-right: 5px;}
	.menu .title { 	font-family:Verdana,Tahoma; font-weight:normal; padding-right:3px; border-right-width:2px; margin-right:2px; margin-left:12px; border-right-style:solid; border-right-color:#999999;}

	.menu a       { text-decoration:none; color:#999999; font-weight:bold; padding:3px; }
	.menu a:hover { text-decoration:none; color:#FFFFFF; background-color:#999999; font-weight:bold; padding:3px; }
	

	a       { text-decoration:none; color:black; font-weight:normal; }
	a:hover { text-decoration:none; color:black; font-weight:normal; }
	
	.colName a       { text-decoration:none; color:black; font-weight:normal; }
	.colName a:hover { text-decoration:none; color:black; font-weight:normal; }
	
	a.vCardHeader       { text-decoration:none; color:black; font-weight:bold; }
	a.vCardHeader:hover { text-decoration:none; color:black; font-weight:bold; /*border-bottom-style:dotted;*/ }
	
	.error { color: red; }
	
	@media print { 
		.menu { display:none; }
		.print_ColorBlack { color:black; text-decoration:none; }
	}

	.tagGroup {
		line-height: 18px;
	}	
	.tag {
		display: inline;
		font: 0.75em Geneva, Verdana, sans-serif; 
		padding: 0.1em 0.25em; 
		border: 1px dotted #333; 
		background: #FAFAFA; 
		color: #333; 
		text-decoration: none;
		text-align: center;
		vertical-align: middle;
		margin-left: 0.25em;
	}
	

	.icon_phone_cell, 
	.icon_phone_mobile { 
		/* cell9x15_trans65.png */
		background-repeat: no-repeat;
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAkAAAAPCAYAAAA2yOUNAAAAK3RFWHRDcmVhdGlvbiBUaW1lAFNvIDIxIE9rdCAyMDA3IDE1OjUxOjMzICswMTAw/oMNkAAAAAd0SU1FB9cKFQ4fOAFeojEAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAEZ0FNQQAAsY8L/GEFAAAAS0lEQVR42mNgIAIwIrGXYpGPZiCgAC7OhCzS0dEBElwKpbHrgNJL0fioJuECpCsCugWFxuUmrOIseBTDwwhdUTQ246hnEklxhxcAAEoEEu0aDv0mAAAAAElFTkSuQmCC);
		padding-left: 14px;
		height: 15px;
		margin-left: 2px;
	}


	.icon_phone_,
	.icon_phone_normal { 
		/* normal13x15_trans.png */
		background-repeat: no-repeat;
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA0AAAAPCAYAAAA/I0V3AAAAK3RFWHRDcmVhdGlvbiBUaW1lAFNvIDIxIE9rdCAyMDA3IDE1OjMyOjEyICswMTAwGVNwGQAAAAd0SU1FB9cKFQ4fEDTrCssAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAEZ0FNQQAAsY8L/GEFAAAAUUlEQVR42mNgGNSAEYm9lAj10ciaiNEA18iERUP0gQMHUGg0+aWM2DShiaHzUfyEz28otjHh0BCNRuO1CV+AwG1jIqAgGpskVW3CC8jSRBYAAJaHEUfbuY0qAAAAAElFTkSuQmCC);
		height: 15px;
		padding-left: 16px;
	}
	
	.icon_phone_placeholder,
	.icon_phone_fax { 
		padding-left: 16px;
	}

	
	.iconGroup {
		line-height: 18px;
		/*
		font-size:16px; 
		*/
	}
	.iconGroup .icon {
			background-repeat: no-repeat;
			padding-left: 16px;
			height: 16px;
			margin-left: 2px;
			padding-bottom: 10px; /* otherwise it gets cutted by line height */
	}

	.icon_flickr_grey { 
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAKIAAP///4Z1f4RzfWRqcVtjagAAAAAAAAAAACH5BAEHAAAALAAAAAAQABAAAAMoCLrc/jDKSSphIYdlrdIa0FmDAGpjVZ5ZSqysC5/i+NFKh4VT7//ABAA7);
	}
	.icon_flickr_grey:hover,
	.icon_flickr_color { 
		/* flickr16x16_color.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAKIAAABlyQBjyBZbwvgDhv8Ag/8AhAAAAAAAACH5BAEHAAYALAAAAAAQABAAAAMsaLrc/jDKGWpgJZdlrSJaZnSWMIBhQVYmGq5Bm6qrnI7kdysdpk3AoHBoSAAAOw==);
	}	
	
	.icon_delicious_grey { 
		/* deliciousFramed16x16_grey.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAJEAAAAAANPS0rrAyf///yH5BAAHAP8ALAAAAAAQABAAAAIrnI+pJ+2yzHNxzFYvjDpfPxnASALBiQZiOaboyronXMrqwLYyTdq87qpECgA7);
	}
	.icon_delicious_grey:hover,
	.icon_delicious_color { 
		/* delicious16x16_color.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAJEAAAAAANPS0jJ00P///yH5BAAHAP8ALAAAAAAQABAAAAIrnI+pJ+2yzHNxzFYvjDpfPxnASALBiQZiOaboyronXMrqwLYyTdq87qpECgA7);
	}	

	.icon_deviantart_grey { 
		/* deviantart16x16_grey.png */
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAK8AAACvABQqw0mAAAABx0RVh0U29mdHdhcmUAQWRvYmUgRmlyZXdvcmtzIENTNAay06AAAALTSURBVDiNlZO9byNVFMXPmzf22NHgh8fGEwLFTqx1M4lxRCSWki1oI7RJtyVKQweioGLF/+D/INJCsVml3AaJYnftRBTBSJNINoqU9WTijyjzudhv5j0KcBSFBk51i3uOdH9Hl2zv7AxVlX5aMSpxu92e4j9od3e3GoTBEudphzza3pZSSui6/rMQ2fesxP44f/OmRCmt3jZJKccfrKyEfuCvEqL8EMfxZ4QQqPl8Hp7nwff9h6ZpPgyjaK/ZbN4vFgufFItLIIRgNvsTSfK2c3Z21hdCPr68dCGEwPLyMlRd19uMsa845zAMA6ur1uPNzU00Gg2Uy2UAQBRF6Pf7D7rd7oN+fwDf95HL5aDrepuura39pmna14wxtFofYWNjA7VaDZqmIU1TzOdzAEA+n0e5XEaaZgiCALlcDlmWPaKtVmtOCLmuVCqfl0olDIdDZFmGQqEARVGQpimCIIDjOOj1foeiKJjP54jj+BsC/EKPj4/Ter0uq9Xql4VCAYeHhxiNRhBColZ7D5xzdDodvHz5Cqenp1hZeR9xHOPi4uLJj0+fnqkLykII2LaNKIrQ6/Uwm83QaNyHoih4/bqD6XSKZrOJ9fV1uO7FTTvKrZogpYRlWWCMYTKZII4TRFGEyWQCxhgs6x6yLIMQ4t8BnHMkSYLxeAzP82AYBjjnSNMUhmHA8zyMxxOEYXQD9iZACHGZJMkL13XBGINpmrBt+5/TJGzbhmmaWEBOkuSFEOISACgAnJycXFuWNaOU7tTrdZimCdM0oap/I9J1HbVaDYwxOI4D13W/e76//+oug87V1dXeYDAApRRSSnDOwTmHlBKUUgwGA0yn0z0pZXfho4vBcZzgnmV1wzD88Pz8fE3TNGRZdsPl6OgIo9HoJ9/3v91/9my48JG7n7a1tfUuVdV3lpaKz6XExwBACH5NkrdfZGkaHhwcXN/eJ1LKuxn/S38B3AFsffdwSLcAAAAASUVORK5CYII=);
	}
	.icon_deviantart_color, .icon_deviantart_grey:hover { 
		/* deviantart16x16_color.png */
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAB3RJTUUH1AgeBQECNBMNcgAAAAlwSFlzAAALEgAACxIB0t1+/AAAAARnQU1BAACxjwv8YQUAAALESURBVHjajVNLTxNRGD3TGfqkT2pbjCSURzVCKa9EXMrCLSFGoglLw8adxoUrjf+h/4AQ0YWpOzcmJoqtxQUiIEgRA33QUuhrpnRmOtd7h5SIbriTO/ny3e+c795z7uWm78+kBYHc9Dl8YjQaLeICY25uzntcP7YqChfnpu/NEKJpsLfb36tEfeaxOnZ+Z7MOgee9f4M0oNDl81WPpEoPD/5FTazd4gwGCEajEblcDuVyedIfCEyW6+L80NBgv9VquWExW8FR8Il8Aqlej+/+2t0mGmbTuTQ0QhAIBCC0t9ujLmf9oSzL8Hg86Al2z46Pj+Fafwhul0cnqIhV/ExtTyQSXya2Uzsol0pgjRmWvx4Z/mYyGR85HQ4MR4YwOjICn+8STGYTmkoTDUpM6McAbrcbTbWJcqUCoa0Nqkbu8KPhsAwDV+rwem877Q7sp+n2VA1mqwUGA4emxgBlbGz8wOrqd5ozoKEoEEXxMa+oH/iVlRW1tz9EvN6OB2azGclkEgf5PIhG6E58kGlxPJ7Ax09L2NzaQuflTkiihGwm9/zlwsKucKYyFWVgYAC1Wo12WkWj0UDoaggcx2HpcxzFYhGRSAThcBiZbPbMHUMrYB0JJQkGg3A6nTg8PIRYE3VCFrNcMNiNZrMJjdr+H4GiKswqFAoF3VbmiKKqUOlkMcvl8wVUKaksK+cJVEIOJKn+LpPJ6J38fr9+HH1nBHrMcg7qVJqKzGoZhq3z7Le1vl7q7ult8AJ/t7evTy9mUxBOJbLZbLqgTpeLurGBTGb/aezV66VzR6Cnih8Vj+ZTqRR4nte9lxVZnyxmObZ2SGs0Yki0cHwr2Fxbq3T19SdqlcqVvb29QZPJpF8aSZJ0XZLLy0yDxeNK9cnbxcV0C8f9+9KmpqZcMJvtNovxDQE3dlpEvop1eRonJ9VYLFa6yIu98PgDflRkerhI7ucAAAAASUVORK5CYII=);
	}	

	.icon_digg_grey,
	.icon_digg_color, .icon_digg_grey:hover {
		/* digg16x16_grey.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQALMAAJmZmczMzLXAzuXl5f///6ioqN7e3u7u7tbW1qqrrfj4+NjZ2wAAAAAAAAAAAAAAACH5BAEHAAIALAAAAAAQABAAAARqUMhJq52p6AIo+BghEsAiAaLSCQmhHEMpoC4MZARsAEWCvgMEQFEgDAzCxScXDAw/0NKy6VQYrouschbVMAdH0GlSBB93hslKUD4r09xV2VBYCNM0EptwLSDuMwovHUVZfoBRHYlQJheOEQA7);
	}

	.icon_dopplr_grey {
		/* dopplr16x16_grey.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAKIAAGphYamtpnmEhMHBwGtscIR+eQAAAAAAACH5BAAHAP8ALAAAAAAQABAAAAM8CFo1HlAIQhVgbsAgKbHYE03V0ogc+ZnZ1pXXqY0eKLuq3dJwOKc1Fuq1iu2AvRuv6MMFjcOc8EfURT0JADs=);
	}
	.icon_dopplr_color, .icon_dopplr_grey:hover {
		/* dopplr16x16_color.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAKIAAP9mM8zMZswAM5nMZjMzmQDMzAAAAAAAACH5BAAHAP8ALAAAAAAQABAAAAM8KAoQPrAUQpVgLsAhKbHYE03V0ogc+ZnZ1pXXqY0eKLuq3dJwOKc1Fuq1iu2AvRuv6MMFjcOc8EfURT0JADs=);
	}

	.icon_facebook_grey { 
		/* facebook16x16_grey.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAKIAAP///+7u74mOln+EjH6Di2lueGBmcQAAACH5BAEHAAcALAAAAAAQABAAAAM+eLrcOibKGYeiWN5MAgDRhnlfeGRGqZ2ZamJfDBqiFJD32846zNMs30RREBiPgs+xQEQelUbmAYKSWBzYRQIAOw==);
	}
	.icon_facebook_color, .icon_facebook_grey:hover { 
		/* facebook16x16_color.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAKIAAP///+vu9G2EtGF5rGB4q0VinjtZmAAAACH5BAEHAAcALAAAAAAQABAAAAM+eLrcOibKGYeiWN5MAgDRhnlfeGRGqZ2ZamJfDBqiFJD32846zNMs30RREBiPgs+xQEQelUbmAYKSWBzYRQIAOw==);
	}	

	.icon_google_grey { 
		/* google16x16_grey.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAMQAAEtNUuvr6rq8v4CChdnZ2JmZmXZ5ffr6+11haNzd38zMzLW1tI6PkVlbXvPz8m5ub+fn5v///8PExqSlpZOTknl8gl9iaPn5+KWorPDw8QAAAAAAAAAAAAAAAAAAAAAAACH5BAAHAP8ALAAAAAAQABAAAAWJYCSOkeMcZBpBGDUMFSVkqmAw07JMBoJIJIGFoggcDg7CoDFBRQiWB0GlWCREBwxg4VBFLiNIpaHwpqCNq3kkQDSmaxHBVyY5EhBIIrCqIBhOIgIMDBUGfBEYPkAjAQRtbyIQPT9nFg2ITw8ACBUCBKAUAA9GYRMPDQ0vDAUUXCkXEAqzCngnIiEAOw==);
	}
	.icon_google_color, .icon_google_grey:hover { 
		/* google16x16_color.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAMQAAFVwsXGX4tDRy/3++ra4tCBb3I6v7bPL9+jp5Q01kmBqf1B92zZOgm6GswE2xuTk3sHW/N7e1Pn6+NTi/vT18bC/25WVk+3z/xNDtTxjuebu/O7v6I+XpqGmq/n7/v///yH5BAAAAAAALAAAAAAQABAAAAWN4CeO33V5ZPpNwQIAxWJoqpE1HUF0mYNVJAPGItgMPJQIgNEZiA4YRUQlIDxEnkCCQFENJKNJgSFQqaCMqznoYEzXo4OvTLpAJhPI5oMoOBpOIwYNCwUZex8BPkAiAxsRBm1vCD0/KWiIHxEKCQ4FBgehCwkKGygiCB0KDAwvDRwWXCkSCAK2Ag8IFIEhADs=);
	}
	
	.icon_hypem_grey {
		/* hypem16x16_grey-89.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQALMAAIBrZeLj4JeEgLC2q////4SKe9PRzu7v7b6yr/b29Yhybffv74RvaQAAAAAAAAAAACH5BAAHAP8ALAAAAAAQABAAAARhsMgywrknjMkD+eAXcMURnsQxeeg5Dp8hCMiH0MlXEYsA/AjED1AjWAjCoRIg+BxyySFj2EyZDIol1WlCaoFOVsK3LBphn0WUGNqwbAqBITSSdGOLkKrTMpIkFRcJGRsTEQA7);
	}
	.icon_hypem_color, .icon_hypem_grey:hover {
		/* hypem16x16_color.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQALMAAOY6AOTx04TFQveTeK3ehPn98O9VKuvVuO/35v/q5v///4zFQu86AO86CAAAAAAAACH5BAAHAP8ALAAAAAAQABAAAARmUMhFArookCX7CkoohgE3IWOqINynqiURHoYxhINdhJWSGIDgYBAE3BQWBbHIBBhCiN2yyCg+V6hDo2mFopRcIRSkKACbR6QslJgaRxsyrmE4jEqCxXeWGLE8cil4eRMVFwUZGx0RADs=);
	}

	.icon_identica_grey{
		/* identica16x16_grey.png */
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXMAAArrAAAK6wGCiw1aAAABqUlEQVQ4jX2TsUscQRjFf7tLRBBhFTxum+GuOGTjFWshWKwkdtE0e4VYBu2FpBMtzL+Qv0CtLVYLlVQabpqYwg1YbPDAzTQeSSM4Srgqxd7KeJz7VTPvm/e+x+MbC6NaYegCH4EPQM1oZcAh8CWWMjM5lkGOgF3A5eW6Az7FUu4VgGOQY2C0hEy/H/lC/E6VSgCsvu0bc3IzCFhcWmLK87i5vuZHu81Vkgw6mY2lzBxfiE3gXdFZXVtjY3ubeqNBxfOYnplhcXmZP90uWadjOnFTpY5s8sCeJq+urw/1vrG1RTMITCgCsDHSfr+yUhrA3MKCeXVbYVizTWRsfLxUoN5oDELPBR7u70sF/t7eDkJ3NnmiAFxIWSpghAhALGVik28YAGenp5ydnLwo8Pp5iIcAji/ET/L1fXLxqDWvRkaoeB5Xl5d8b7eZmJxkutnk+OCAXq8H0E2V2rcAWmH4Gdgp9Q9UqlUetUZrXUATDkCq1LkvhAvMlwk8aF1ML+qXU5xSpb76QnwDAqA6hJ8A/xj4bNaQh7TCsEa+YG+BcyArvnG/FwFvgOg/5k6FWvVaEx4AAAAASUVORK5CYII=);
	}
	.icon_identica_color, .icon_identica_grey:hover {
		/* identica16x16_color.png */
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXMAAArrAAAK6wGCiw1aAAABaUlEQVQ4jX2TMW7CQBBFn02kIEVCpIhEJIqV0qWCzh2uIjp8A8gJiE+Ab2BxApwTxC7dOVXKmAYpBYoLikg0JhUuIlIsixbL+Esr7czu/Jmd/WOgwYc28AKMAaEdZUAIzF25P8HQgh1ggSS5hBxwXQjOCI7BbzWBZTwrEuNY9reeuWvbPI7HtIRgm6aso4hNkpQr6buQ4YPnw0GtD887VCGeTA76PV8+FxPZsFNmazarrPlpsaBr27rLUQRCefrTae3DH0Yj3Wz7IEzdc92u+wC46/XKrnOCIs9rCX6zrOzKTWRHAVhHUS3Bdrk8s11ITaTCAFgFAasguEjQHQx0MwRoDGGJlO+pimK346rZpCUEmyRhHYbcdDrcWxaf8zl/+z3ATwyvSokeUP1/GlpCUOS53qvbBkAMyVAq0aojKPJcZVf4aqhdDPEQ3oEe0KmIT4E9pWEzKi7iS3EJwAYSIFNjfDxzgAHg/ANyqId7Kk7R5gAAAABJRU5ErkJggg==);
	}

	.icon_icq_grey { 
		/* icq16x16_offline.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAIMAAUFBQZiYmPHx8cXFxbm5uQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAgALAAAAAAQABAAAwRNEEkEKrUzA8F3z9M2BCIJVmWKecJGCu8nDi35DiNABTwPEICeT4KqEI5FHYXDIQGZMN3MtplKe64sllgR5LwkTAicAhGxW/NFKla7JxEAOw==);
	}
	.icon_icq_color, .icon_icq_grey:hover { 
		/* icq16x16_online.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAIIAAUB9SG/Kd4DpmXDggP3/bgAAAAAAAAAAACH5BAEAAAUALAAAAAAQABAAAgNLWFrQ7CsCIcKsIK45rOiZ1HweCF0CAGKUxQzwAFglyAQ4DhBz7j6NHYEXDKEwPEorwwF5mq6ex5PKGUcrU2hD4vw00rBm4wiOz+gEADs=);
	}

	.icon_lastfm_grey { 
		/* lastfm16x16_grey.png */
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAK8AAACvABQqw0mAAAABx0RVh0U29mdHdhcmUAQWRvYmUgRmlyZXdvcmtzIENTNAay06AAAAJhSURBVDiNnZPPS1RRGIafc+d21dHRJn/MgJQFbSLEorBFi3ARrTIYMwxSiiQDXZq0sFBqIUVES3MRQmEUQhnUP5CQSgUhbSQwbTRnnDERr/eee+45LSzbBfquvo+Xl+9bPK94/PDBKeAeUM/2NAn02DrUz4HkNsP8OfjcDnW4k/BfJW0VqK3NCIExBgAhBOLP/D/PVqHCaINUCt/3KYvHkb7E9zYocAqwIxYq1PjSZ/eePWitWf31a8uzfT9ABpJDtbU0Np2nsKgIgIV0mtGREfLZDMUlMa53dlKVSACwnM0yPDiIv7GB5UufeHk5Fy618nV6mlvd3dy7cwchBJevXWPd3eBkQwOO43C75wYD/f1YlsX+gweRgcTyPI/DdXXoMOTls2eEKiCfzfDi6VNipaXUHTsGQDQapXpfDasrK/TdvMnk+HtCFWL7vk+stAzXdVlbW6MkGgXg28wM+VyO4yfqGR4aonrvXjq6ugD4MD7Om9FRZCCxVaBYX1+nJBbDGIPneQCoQDI1McHpM2cIw5C7vb1UVFZQe+QoF9vaWMnnePfqNZY2mi+fPwGQamnB9TwKi6Oca27m7dgYQRDQ3tlFWTxO+keaj1NTBFJSXBIjUAHiemurkYHkbKqJxlQKKxIB4PvsLAN9fdQcOMCVjg4SyX+8ZTMZHt2/T3ZxEXG1pcUYYwjCEMdxqEwkyC8v47ouuyIRNKCUoiqZxHEcjDGk5+dxbBvLsrCV2iTRApSULMzNIYQgIgRa603aLIvc0tLWB7ZlobVGa42tlEoD1TvsQtpWWrcDT9h+I38C7b8BVaId9f+qVGMAAAAASUVORK5CYII=);
	}
	.icon_lastfm_color, .icon_lastfm_grey:hover { 
		/* lastfm16x16_color.png */
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAK8AAACvABQqw0mAAAABx0RVh0U29mdHdhcmUAQWRvYmUgRmlyZXdvcmtzIENTM5jWRgMAAAJYSURBVDiNnZNLSFRxFIe/ex1ncnQGnylYms+C6IlmiDEFGSWlQdmujbho0dYWgZVQLSxQKHJXtGkVrpTUXflY1CIzlQrx/RhSkVHncR//e1qkZrUI+8GBc/jO2ZzzO5p56WgAaAZOsDO9B25p0arDC0DWDoc3FXTZtvO/wwBZLstWW5UAIj9zTQNtW6cAzgbTtzGXaSkcIKYcwkrQsnOQaIS4lSUS43TidQ3bEdaVg5NbAI5Cn5kkaYMxebJARkvz5Mu9BrHC67Kp1bGvMni9WkZK82SwJiDrUxNbLDw7LUM1ARkvyxc9alhEiw6x/24zwf53vA0cY+DaBUSP40Drc4LiIqXuJnqCl55z5fTVnkfTdbwl5Rimjb5mKHyVFxGl+HanAf/yIu6Rzww33caTmob/4lUcNOJ9fpIOHiE2v0Df6RKWXr3EMh30qGnh3p2JubaK/X0RsRSarYgM9BIOLrCnqpqR1kesTY5T3tLG2f5PFDc/xfCnEjNtdMtUGKEQnuQUovFuwoZNxLCxYgZTbzrIPF6Ksh16K0/RVVHCh4dN5NZcIaPuBuuGhe5YioWebgCKGh8wr7sJZe8jr/E+o8+eoCyTstY2JCePlbExJrq6UKaJKyWNmKWgO8Mn7elJ8rHlsTi2vbXp5ZFheV24V3pqL0to8tcFRERWZ6al80yFdKb7ROtI9ooDxERQPj/e/AKiszPI8hIeNASIIewqLEZPTASliAwPkYBGvAZae6JHfnMboPO3CzeDP7jLstQckL3d4M4/HmAbn3PZyqkHXrDzjwwC9T8A1f5Cpa/4mhIAAAAASUVORK5CYII=);
	}

	.icon_linkedin_grey { 
		/* linkedin16x16_grey.png */
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEgAACxIB0t1+/AAAABZ0RVh0Q3JlYXRpb24gVGltZQAwMi8yOC8wOU/qNWIAAAAcdEVYdFNvZnR3YXJlAEFkb2JlIEZpcmV3b3JrcyBDUzQGstOgAAACDElEQVQ4jaWSPWsUURSGnzvMZDfGNa5BdrNrEEREULQxTYLGTgvBwtbKX2Jnp5WIlZ0/wFKwkUQIQRDxI5rdrNGsMcZozMzsfN1zr8Usk8AmaTzNuVzuec/znnPV/YePmJtfsEop9g07mK21TE9NKndufsFenblCY7x+cPGuszWWb6tdZmdfWQdgvF7DWovneYwMDx9MYkEpxYlmA2MMLuQXANdmLjPkebycX+DX5u9BCrVzViiM9AVEBNd1GfI8AFzHQUT2tmHyJCI7BL0oBuDZ8xdURkb42v2+b7E1pi+g88YAURwxdrTKpQvn8xprGatWOT5WZWPzD2s/1jlz+hQlz2Pxc4v3i0tYI1jTF+j1Yo6NWhr1GgArq12qoxUa9RqNeo2L584WEM1GnbAX8fbdB4wxOFgIexFxkhaP0lRj+uhxnPD4yVPu3nvA1tbfXGS8hr/tIyI4AFEUkSRJIZBlGabvtbu2Tmv5C0EQFJs5UjmM7/v9LdjcQhzvEGitES3FtIMgQESKzWit8bd9gJzgf8Ldy0Ka6aKbiOD7PqKFbDdV2ANA3bp9xw5XRjlULjPRbAKw8XODcmmIUqlEEAS02x1EhJMTTcrlMmEY0umsoLM0n0G0HYKBT0ttRAtGNDrTiBGMzmlEC63W8qCF6alJ9frNR+soh9D30Wn+K9MkJomTgYLdcePmdfUPfiYyHWKWNpgAAAAASUVORK5CYII=);
	}
	.icon_linkedin_color, .icon_linkedin_grey:hover { 
		/* linkedin16x16_color.png */
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEgAACxIB0t1+/AAAABZ0RVh0Q3JlYXRpb24gVGltZQAwMi8yOC8wOU/qNWIAAAAcdEVYdFNvZnR3YXJlAEFkb2JlIEZpcmV3b3JrcyBDUzQGstOgAAACIUlEQVQ4jaWTPWsUURSGnzszu04SN7skZiVpVvxcbBQLO20sFButRSLYWlj4A2z9DYKFHwgB/4GgoK0fJAqJCholhCyum5nMTmZn7pfFXTLZqJUHDueceznvec97ueLWk+c8XfxptRcg+Idlwzgoa08rrl2eEcGjpZ69cuEMRw/W/9482JVvu2Byy6dvmzx+9tF6Ajg8M4kxltD3aFR9sJSu/3QvEByfbYBSBACe58jfPnmA0Pd4uNJjNSrcOL+cjF+u41tbAkhjCX1B6HsABAhkYUvqctca+TAWCrQksEBcaGLg3rsO05WApY2sbEgZzZUaAuWgpGMQ5ZpWWOXqISekldCqVWnVK3zvSZbXB5w7MsFERfBqOeb1h18OSCkCDMSpxgSW9lQIwPu1jLlaQLsZ0m6GXGzXdki058bYTjJevOlgpcJDQZRq+pkpXy43O0z7A8PN+185f3eJjU0n7Im5caIoAy0dQNzXpCMAFq2diCvrGW+/RMRxxlrXaTMzWSGO0qEGCuJE0x8vAfLcoJQDUNoQR9sgJUpqd6Y0cc+p6/GfFqAg2tL09+uRFZQyO9OiKIO8KM+kIUqcHqJ2Y8EmzWPUPZ/TzTEAVn+kNCqGRtUSxRmLy10oCk61xmmEgigpWPzcoyY6iNr1BZskUzA77cYnBRQFFLmL+Z56l9VEh2D+0pR48HKflVKgu10m83V3m25h+1ujC+/57/N3zorfiWUj74W9eeIAAAAASUVORK5CYII=);
	}

	.icon_msnim_grey { 
		/* msnim16x16_grey.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAMQAAP////f39+/v7+bm5t7e3tbW1s7OzsXFxb29vbW1ta2traWlpZycnJSUlIyMjISEhHt7e3Nzc2tra2NjY1paWlJSUkpKSkJCQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAAHAP8ALAAAAAAQABAAAAWUICCOAHEQZCoO0dNE0qCO0VEcSSPN5WMQhgSDglIRIIgDYtGgFHiSxYLReFQCKmzh4ng8LgYe4mFTLiSIVMCRIBBuCMUC8sACBpDbwWBAJBRUEREBAXlxB0p/VA4QEw4NcQ4MCgmKDF0wFRAMDxYNUlMNXRAXFhALFRcSEg2tDqMTEGF3KAaNFBQVFBIJPCsEAnYjIQA7);
	}
	.icon_msnim_color, .icon_msnim_grey:hover { 
		/* msnim16x16_color.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAOYAABtMU93c4WezsUKTlLa0uS12hZ3Y5v/5+klYX2OQk2l4e3/Ey9XO1WSotSVzdZLW3+vr61WGiqGooVGbphhXXHm3xGajpm6IiWNtbI3U2DqCkajl6FKIkkVxcsXDxDdjZo2XmEKGiTFeY+Dk41edqXW5wi9KVfn7+EqUnXZ7f2ysuISOjf7/+oi+vmNyd4bMzi9pa1lxdUeJmdPW2yxaaRlSWp/l5bq8u3KxtlNtbq7q8muAgeXh4F2nsn+GjkyUo5vR01ycpujp7fP18GCLkl9xcYPR03i+xlajrZjf42SttInW3meisEGJlTtqZCNLTWmvu97f5P/4/G1/gcjMz06BgjxcW3l+gf///47L0Guzv5rd5lqjrHu9zoTDzFmjpPj+/ubk5XG7xFKWodLT2GGlrmBrcT2Kkqjo8T1jbNbc3MC9xHO1va7q9fT09iFKUgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAAHAP8ALAAAAAAQABAAAAfDgFiCg1gBHlGEiYIjCgkWVUVhioMuGTYZC19mk4VEBm1JXg0wiIpqES8ZL1pcMDOcOQJaKj0DCCeKUlhkJkE/P09UnGsXQJcvODE3YIRuKy1oOjYPLxVQHD4HgkJTGw8PWwZGXmINSCEKB0M7Ni8lS0svC0dKSBMyDisgWSVBUEcAj6hQQmKAhgJWdkBBUYOJlodKekz40QQAhSsSaADA0KFMGS4kxqA4AyMFA2ZhwoBhMMVJGhgiPrggwGkbDwi6CAUCADs=);
	}

	.icon_myspace_grey { 
		/* myspace16x16_grey.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAMQAAP///+/v7+bm5tbW1s7Ozr29va2traWlpZSUlIyMjHNzc2NjY1JSUkpKSjo6OjExMQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEHABAALAAAAAAQABAAAAVhICSOZCkCaIoGidMUwCkIwPE4BvLsjyAWO+DOseA9DCLdQ3lLGAcigsMxsOECipshBgEYtoECYUUYc7MPRWPHsLF9EKPcqBDN7w87Xq7f804oRXuAXgiGgkaEKkx/Jo4jIQA7);
	}
	.icon_myspace_color, .icon_myspace_grey:hover { 
		/* myspace16x16_color.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAMQAAP///+/y+d/l8tDZ7L/M5bPC4a+/35+y2ZWq1Y+l0oCZzHiTyXCNxm+MxVR2u1JztUBmszBZrCBNphBAnwAzmQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEHABUALAAAAAAQABAAAAViYCWOZCkCaIoGzSQZwCkIQEJNh0LtlCAauwJvAuFRDiIdZTFkGAciwmQysOECj9shVgEctgEDYUUYc7MUh2QXQfAivopxbnyI6HjKPT/f83knKEV8gV4Kh4NGhSpKiiaPIyEAOw==);
	}

	.icon_skype_grey { 
		/* skype16x16_grey.png */
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAgY0hSTQAAeiYAAICEAAD6AAAAgOgAAHUwAADqYAAAOpgAABdwnLpRPAAAAAlwSFlzAAALEQAACxEBf2RfkQAAABh0RVh0U29mdHdhcmUAUGFpbnQuTkVUIHYzLjMxN4N3hgAAAZVJREFUOE+Fk89qwkAQxtsnaN/EvkkfoX0SFcWroqAgeJVEEEMOERURD6Je1NxyCpKTh4ARPChepvuN2XWzxXbhI5nZ7G/+7OT1RaxSqfQhHkWhT9hiubDz+byf2s8fOCyUOI5D2+2WhXfh07UTdlHo/RdJOJ1er0er1Sqj2Wym7MlkQp1OB8BE6DsDQaTRaETT6VRpsVhQFEV0PB5ZYRjSfD4n13WpUqkA9IAAMBgMeBPyPI9utxthxXFMp9OJ3+FDJpZlyUzu5aCEZrNJ3W6XtVwu+UAQBBnf+Xym4XDIvlqtBkhBAnLIotVqUbvdpvF4zIDr9cqwfr/Pfl0IKM7sVC8AqFarSpvNhiFyXS4Xvh39G5zJAMrlMulqNBrcE9/3CQAsNFt+YwJwz3zvSHW/31O9XldzYNs2AwAz5gMDyI0syA35cZIknAFm5HA4qAwMgCMBb+mQcATcuUxb9mG9XpvR2db78GXQuQyUZPp125xKQDCufx7S9u8l6Etsohz0RDX2CRCBcv/+rWmTMWyOHlke/gEzb0H7b4tP/QAAAABJRU5ErkJggg==);
	}
	.icon_skype_color, .icon_skype_grey:hover { 
		/* skype16x16_blue.png */
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAK8AAACvABQqw0mAAAABZ0RVh0Q3JlYXRpb24gVGltZQAxMi8xOS8wNuzjNdgAAAAcdEVYdFNvZnR3YXJlAEFkb2JlIEZpcmV3b3JrcyBDUzQGstOgAAACFUlEQVQ4jY2TTWsTURSGnzsfSWisuZqkEEUtFiEg0uwrrVARXXXyA8RuxJXYbFza/AEx+AdaEBHcJP4AKXShC6GkVNCFFjHWNmJ1YrAzk4+5LqaTmETUd3cP933ee+7hCADKdg4oAgsEegYUycsq/5A4NK9dP2XK2ZQBwPrXDo9q7d/vVQ+hJfLSVkoFZiEQlO2ylTGt2ZQ+QP7WUhyPCAB2HMX6fodX37s2UFBWYjUEGIA1OaZRd1XPfMwUXJ0wycQCwPaBzxEDzo/r8smn1oqoNAghGsAXz6fuKeqeotmB21MRZpI6LR8MDS6nDe6ei5KMCK5MmAAPRKUhQ0Blo9Flz/PZ83zOxgVjuqCy26bw2uFW1eH+O49mBxxf0VaKkzFNAndCQPFt06d2oKi7ih0naGU+bTCfNpCG4HGtzbUXP3m536XuKsZNAKxgCsEY1YmY1vuDYjbKzclI7/yjrXj6uc29N26vtusqyEvRA+hicL5nxjTmkgZzKZ2FjIk0BYUtl4fbHgC+AvJShLHVroKuggtHdZ7PxPEVrHxssbjhsLjhADCd0PDVoTkIzoWAykByymDtYpzF0xGsjEkxGw1SGj5DWg5bSAAfAAmwnI2yNBVFmv2+Su89ClvuMID+jbJ9A1gd/gdpCjYb3RHjKKAPKYUv+Q9VxEgpaGeJYM65v5ht4NIo4E8q29ME626FyQTrvvkLDunH3t33VgYAAAAASUVORK5CYII=);
	}

	.icon_soup_grey { 
		/* soup16x16_grey.png */
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAA3NCSVQICAjb4U/gAAAAOVBMVEX///91dXV1dXV1dXV1dXX////4+Pjy8vLj4+PT09PCwsK3t7etra2jo6OZmZmQkJCHh4d+fn51dXW4ns3rAAAAE3RSTlMAVZm77v//////////////////DJBZzwAAAAlwSFlzAAALEgAACxIB0t1+/AAAABx0RVh0U29mdHdhcmUAQWRvYmUgRmlyZXdvcmtzIENTNAay06AAAABwSURBVBiVZY/ZFoAgCETdMCNz4f8/NkCz03EeFC+DgDEi61nWvLKBVGEiR0tO8xr20uUSj/hrAoAkVcPQIz8xDYvns3D+0hLyC0DED9ApBPIH6D4YoAL5tFwtMyijL7etqyLMwSoitnewbfR9uf/6DzQ7CbeeuBZdAAAAAElFTkSuQmCC);
	}
	.icon_soup_color, .icon_soup_grey:hover { 
		/* soup16x16_blue.png */
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAA3NCSVQICAjb4U/gAAAAOVBMVEX////OHS3OHS3OHS3OHS3////89fb56+301djuu8HonKXlipXieYXfaHXcWGbYSFbVOUjSKzrOHS0pcUlhAAAAE3RSTlMAM2aIzP//////////////////BQ5lSgAAAAlwSFlzAAALEgAACxIB0t1+/AAAABx0RVh0U29mdHdhcmUAQWRvYmUgRmlyZXdvcmtzIENTNAay06AAAABwSURBVBiVZY/ZFoAgCETdMCNz4f8/NkCz03EeFC+DgDEi61nWvLKBVGEiR0tO8xr20uUSj/hrAoAkVcPQIz8xDYvns3D+0hLyC0DED9ApBPIH6D4YoAL5tFwtMyijL7etqyLMwSoitnewbfR9uf/6DzQ7CbeeuBZdAAAAAElFTkSuQmCC);
	}
	
	.icon_sourceforge_grey { 
		/* sourceforge16x16_grey.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAMQAAIh6c7y0r9LMyZ+TjPHv7qWalNrW05WJgsW+urKoo////4+DfObj4cK7t5OGfqqfmfr5+batqc7IxdXQzsC5td/b2Ovp6K2jnrSrp+Dd2wAAAAAAAAAAAAAAAAAAAAAAACH5BAAHAP8ALAAAAAAQABAAAAWFICKOZCk+Q6qu6SMOQOwc9OEsCzC8gDOvttwOMVg4MBJE4hFoRlI8BMRgqUQUWMXztSBMBg8MRSFIHYYDRwDCoCQQCkJmcn6dLxWIYMw21IkHBSkTEAFkZmgLDAyEE1dfaYk7AgEFFw0JAwcLaD0/LA46PABGNTQ4oggoLKwuDa+wsbINIQA7);
	}
	.icon_sourceforge_color, .icon_sourceforge_grey:hover { 
		/* sourceforge16x16_blue.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQANUAAOlmFPWpd/vfzu+DPfW4kfCLS+tuH/759vGWW/jLru17Mva1ivzr4PjFpfKfaupuH++EQfrVvvezhPi6j+x4LPGSVO5/OOprG/Kjcf7z7PWwgvGcZf///+t0KO+MQveca/e9lOpwIvjQtvjJrPzm2PbBnv/8+velc//37/3u5POibu+UY+9zIfSsffrYwvecY/KibvfWtQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAAHAP8ALAAAAAAQABAAAAaswIlwSCwKKwOIEuJpepaVxWQAuFw6lCylE7oABkLIFWtRWhSdBwASDnUcJcKm0moFYBbwREzIiEgRKhwcJiYYFkIeBgwjFhUOGhwNFmceiR0BBwIaGwscKS4jFJYTHgoWCBEmDZEZAiKjiRQFEBYjGQGSlLF7IQICCRkjggkDAx1sew8eCw0tBQgSGwMKIcliHWRNlBYdF8lUF25aWV1fR9xL6rVREu7v8PESQQA7);
	}
	
	.icon_spinde_grey { 
		/* spinde16x16_grey.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQANUAAHR6fa2wstXX2JCVl7/CxP///4OJjKGmqOLj45qfoXp/gbe6vMXOzouQkpWanH2ChKmusPf4+Nze37CztdHT1JmeoICFh4SMlKesrsXHyI2SlMzMzLK1t+rr656jpd7m5nuEjLq9v8fJyvHy8gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAAHAP8ALAAAAAAQABAAAAaPQIhwSCwKN8ikUonBiA7QqBT6PFShkoK2EH16Mp5wtiOQSMJfT4VQaRdG7Xib7SA47pFC5c6vOwYhA4IBWggJgoKBDSENjQ0OWQUBjiEaGgsXmReOBRGaCw0GHAakpQYdBaWjFhwWrhQUGwgFAq6sFg8TD7tbBRS7u7oKAQrFxsfFxAABzM3OzgDR0tPU0UEAOw==);
	}
	.icon_spinde_color, .icon_spinde_grey:hover { 
		/* spinde16x16_blue.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQANUAADWNvZXF32Kr0dXo80qbxny93qzV6b7b6vj7/XK12UCUwom92VCfymeu1TiPvqDN5Mnj8Funzq/W6+v1+XW422yz1oe82LXW5lWjzFCfyZrI4I/B3P///2Ot1tTn8TuSwN7u9oe+3JzO3qTP5c7l8MHe7vf//7vZ6gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAAHAP8ALAAAAAAQABAAAAaQwIJwSCwKJcikUlmgGCjQqBT6dCauCRJny8EaEpVRZQzhgEok0jhcaYwacM4EToe/BQ+BHsFp6P94AhEaEYUhWwMVhYWEGBoYkBgCWhwWkY8ZAQwZnJ0cCJ2aBBsEpaYEIBympKMKricnFx4cB64KpAoLtly0trmuCx/Cw8TCwQ4WyckLzMzKFg4A0tPU1QBBADs=);
	}
	
	.icon_studivz_grey, .icon_schuelervz_grey, .icon_meinvz_grey { 
		/* studivz16x16_grey.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQANUAAFBSVerq656foYZ/gMHCxGFjZra2t/v6+9/e3pKTlWhqbdjV1omKjKump1xfY7m7vPf3+HFzdpqbnYqDhFhaXcG8vWVnaufn6MzMzJKLjKqrraanqf///+/v8Hl8foWHipWXmsK/v1VXWqKkpd7e5o2PkpqTlPfv77q3t3V3esbIybOuroeAga2lrWxvc8W9xQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAAHAP8ALAAAAAAQABAAAAaYwINwSCwah4nFURggCUuUj/CiJG4KlmuU4RBJigLHB0JAQAoiSoe42CxQq0yjgUlshipPoYQYZSYsDQcjURcHCwoFISEZfwMTBiIiACIYBwEJECEmGSwTHRAWFAkIQg8FEQgIJgsrBgkSEEMBLgUFJCEGgxQiDEQPJSMPFg4UIF0iKUsRDgULARoWEUsgBQREa0cLKkvd3UEAOw==);
	}
	.icon_studivz_color, .icon_schuelervz_color, .icon_meinvz_color, 
	.icon_studivz_grey:hover, .icon_schuelervz_grey:hover, .icon_meinvz_grey:hover { 
		/* studivz16x16_color.png */
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXMAAAsSAAALEgHS3X78AAAB6klEQVQ4jaWTIWzbQBiFv1YGPzAwCDhoMBAwYBBgMGAwEDBgNAUMFBQEBgwUFBgUBFpDAQUFBQEFAQMGAdYUYFBwoMDwQIA1BRwIOHBqCjK1aTNNm/akA3f/vU9P73Qn/tHv+A+d/nHq4azU1Nr+HcBsoF27Z3NetsxXHdOFebmzdjQPL8DgEDBbGsqqQwIYf1Q0em8UHPmVptYdzjrGeUz6PjkG2C3gHVksFHnMxLeQJETvFPF5hbMOCeFilBwnqFtHFEL1NSFdzJDJHFU3kKQ4EebjMTeNJe4JqnfQwfzeklxqhlONWVuybYtoDXWDc+DqBgIhS2NUTyjvWvKiwfzq6lSFQrfZb4aJgrqG1jwXiQeWDe11RTlvcQ6qlaF/XlHfd5xmfaG5SskHEXmqIBCQA3MYIfdz4vMhKhIkhNGwT1NmZAPFiX/0u1ndMbkxxBHoswjZWpgUUFxgV5rFYEhtHJFAcZYQhS8dBGYDxV23f2MLphfTbCzRZEr+KWG6UZS3Bpwj/6BemQGCSneksRCriH5PSAuN2zrwjpFtWawM+H1HpnO81cnbv9Cf7BuWABaXCX0lzJYdN99bIhH0dfaa4B/97nB9+fawCz8vd7c/1ru3s/VPf3R2lKDWls7DaBAdxf2djgD/qiccXxK0r0QAXwAAAABJRU5ErkJggg==);
	}
	
	.icon_twitter_grey { 
		/* twitter16x16_grey.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQANUAAPv7+6Ojo6Wlpaurq7W1tdvb2+Pj4/n5+f39/e3t7dXV1f7+/q+vr+zs7NfX19zc3NjY2L+/v83NzcbGxuDg4N7e3ru7u+7u7vr6+ra2tsvLy7Gxsdra2qKioqysrOLi4vX19d/f39PT093d3dbW1qmpqfz8/Kqqqre3t6ioqKampv///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAAAAAAALAAAAAAQABAAAAZ2wJVwtRgaj0NJJIFEVgIBS/OoUJVQRIBpSlKdNiISxEFqILuDk2qtEpSYRvQpRacHKMfuyYPqozIaIFQqKSgHJohbSA6EWFNDBl4DIVomACsIRwcMJSclBH0EExhIBW6edR0GTRwMbG0nF1MAHw8jDwVmj5lNQQA7);
	}
	.icon_twitter_color, .icon_twitter_grey:hover { 
		/* twitter16x16_color.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAOYAADTU//r+/zjV/znV/1bb/zfV/6Dq/yzS//n9/1jb/yfR/0LX/1fb/1Xb/zbV/7Lv//f9//T8/9X2/5/p//L//7Du/+r6/57s/z3W/874/67t/7vy/7rx/////f/9+1Ta/5ro/6Pr/6/t/5/r/6rt/5/q/yvS//j9//X8/6nt/7/x/6Hq/ybR/9f3///7+FPa/////obl/2rf/7bv/6Ds/0jY/yXR/1Ha/9L4//D+//3+/3vi/7jw/6zt/zfU/2Dd/9L3/6Ht///8+Yrm/zPU/y7T/////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAAAAAAALAAAAAAQABAAAAeLgEaCRh2DhoeDQzI4iIgPLAo/jYcTRQANRjAuQpMGRQ41ICNBNBcZiJ4DBUWsRQcAEocrRQMCRLe3CjyHngIYDAkJDB8xFoclRUQEEQHNAY0hyZiTgxtFAgMzEAgIJ0Y6hzkLAAU+LwQENzsoiCSvAgC4NiqNKQutRSYFLZMUHBoVRPQAQs2Ih0mBAAA7);
	}
	
	.icon_vimeo_grey {
		/* vimeo16x16_grey.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQANUAAEFFRpmbnPX29nR4ecfJymdpaoaMjaywsdja211jZImPkL6/v/Hy8n6EhVBUVdHT1KOlpo+TlICEeW1zdGZmZkpPUeTl5bS1tf///7/CwtjZ2ZSUlMzMzFZcXWFnaIyPj6isrbW5umtrc5qfoZKYmcXOzsbIyURISeDh4dbW3mNrawAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEHABIALAAAAAAQABAAAAaEQIlJMSkajwqOhHBsNh9Ep5TUMCqqxUboMCgasBmMoErCmE3exoBgxoAmHIb5kY5ANObL4BQwh9IJDglzIhNsGF0TX0UeFmYTZRgLCWlGF34oGAwORotFH21mBQWdWBMeoQ2UpUcQmg0dTQYkRxUUALFNI3RHCYVOGhIPIwrFxscjCBJBADs=);
	}
	.icon_vimeo_color, .icon_vimeo_grey:hover {
		/* vimeo16x16_color.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQANUAAAdph7DGzmKOnlrH4ym325n/ABCu1vD5/AuUuYO3xjV7keDo65Xb7Ql7nTu83qri8YKntHfK4Aynz7Ld6UWTqkC+3wh1laG/ytHr8mSluRmPsO/09RVbc5PI1xyy2YbW6tDd4r7p9P///7LW4EN3igqHq6Te7ZGvuhdyj0rC4AuawLXm8sHc5Em923fR6KHEz0R8jwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEHAAUALAAAAAAQABAAAAaCwILJYSgaj5WH8MhkrojNaIpgdFCLhI/LU7QWGaIDNSUqm7oEj6ksihgmmzIL3UqAyh0PAFJ+oRENCnISBiNlFGhFKgtlBmQiAQiJRRdlHxgiGyhVVwYZbGUwhJMGGqACkpxGEieZAiVMDilHFiQcsEwDK0wIo0whBSsDDsTFxgPAQQA7);
	}	

	.icon_xing_grey { 
		/* xingXL16x16_grey.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAOYAAL+/v7y8vL6+vsjIyP39/bq6uu3t7SgoKCQkJCoqKikpKdnZ2SsrK/Pz8+fn59/f39LS0vDw8NPT0+zs7DY2NtjY2M7OzsHBwfz8/H5+fujo6OXl5W1tbfb29unp6czMzPn5+ePj45OTk6ampjg4OJ6ensXFxSMjI9DQ0MTExN3d3evr63Z2dsfHx7Ozsy0tLfv7+9fX13l5eerq6tHR0UdHR1JSUjs7OyYmJv7+/sPDw9TU1LS0tNzc3KCgoNXV1e7u7rm5uXV1dcvLy2JiYi4uLru7u729vf///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAAAAAAALAAAAAAQABAAAAeQgEiCg4RIEz8SG4WLIClGBQ6LhQtGRxaEIywyRoMNAAJHQIQlJwg3HoIQRgE7i0QJBxlIBgECFx2LAEUMFCsoR0c9khwJCkK0Ry0YiwUvDCQqH7WRizYKByIRRgADBIs+CDg1DTkmAgAziwsuPA+CIZXdkoQEAwBG7vODGkcBOjD6Bg0pECRGQEERINCoMCgQADs=);
	}
	.icon_xing_color, .icon_xing_grey:hover { 
		/* xingXL16x16_color.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAOYAAAAAAP////T4/ZC3wm6frOry8+Hr7BVjaBhhZB1naS11d6HBwqDAwajGx7bQ0bTOz7vT1L3U1QBXWABPUABISQFWWECAgXqnqABTUgBSUgBQUABPTgBPTwBNTQBKSlOQkGGZmW2hoXGjo8DX19vo6ABUUgBSUABJR+zz8ODr3fv97f3+9cjZAM/bAM3aAMzZAM3ZAMvYAMzYAMnXAMnWAM3aCM3bC9DdGNLeI9PfJtXgLdbhNNjjRNvlT97nUd7nVt3nXOHpaeLrdOTrdefthOnvkezxn+/zr/D0svH1tPL2uvP2wvT3yPf51/z97M/aANDaAM7ZAM3YAMzXAM3XANXfINvjJ9fhKNjhMd/mQ+PpYeXreu7yo+/zqfb40fr73+PnWvj5rfX3rP//7f7+9/7++P7++QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAAAAAAALAAAAAAQABAAAAeUgAGCg4QBSlpgXIWLKjlUU12LhVsxLz2EDSEiEYNNNlA1TIQMFCcJBYJALFJBix8mGxcBSy8uN1+LIxIlCChZUTBEkiAZEwRiMFE6K4sQFRgHKVZRT0eSFhocA2FSUFdmiwseHQoCY1VPLUmLJA8OBoJGMjA7ZZKEZFhPMkX3hEjJcDjxN4jHDBpCCAry8sPHkEGBAAA7);
	}

	.icon_yim_grey { 
		/* yahoo16x16_grey.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAJEAAP///5mZmQAAAAAAACH5BAAHAP8ALAAAAAAQABAAAAIqhI+py30BY3AiCgGkfJDjiIAQlgUkNxqWkqrm0honKk7KhZOzw/f+fygAADs=);
	}
	.icon_yim_color, .icon_yim_grey:hover { 
		/* yahoo16x16_color.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQAIIAAf////8AAAAAAAAAAAAAAAAAAAAAAAAAACwAAAAAEAAQAAIDLAi63P4wrkBrkKIKAaydFMhVDElxXYCCp6I5ras+sbKy5uVsPHpLwKBwuEgAADs=);
	}

	.icon_youtube_grey { 
		/* youtube16x16_grey.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQANUAAAAAAOPg4Kmenot8fFVVVczMzP///yIiIpuOjr61tYZ3dxEREfDv79nU1I+AgXd3d5+SkratrTMzM4yMjLu7u6OWlt3d3a+kpPj394GGd+nm5tTPz6abm9vW1rKnp4d4eJOEhMS9vZaJiezp6QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEHABkALAAAAAAQABAAAAakwIwBMDQYj0ihBTABWJDQ4wNAYBwAh2FhAWUACoYDY0H5cqHf8Lg8OSO/VqxBAiBG79GGyAGC+EEIFyEBGhtGICNGCA4KGAgKIiIbCUYQAwYCmRAMDRAOGwgVlR+ODAUdGxioDAwflZcQASEbGx4NDSMjDq8GsQkbDREdARcJIkYVsBoGGx0GDZQMuwYeCBwIENeBixEgHgZCIRHjHuUX4xEh4EEAOw==);
	}
	.icon_youtube_color, .icon_youtube_grey:hover { 
		/* youtube16x16_color.gif */
		background-image: url(data:image/gif;base64,R0lGODlhEAAQANUAAAAAAN3d3f8AAIiIiP+Dg/9RUZn/ADMzM/8zM/////+zs8zMzCIiIv8iIv+urru7u3d3d/9pae7u7v+lpf84OBEREf/Gxv8QEP/U1FVVVf+env9BQf/m5v9mZv98fP8oKP8KCv/29v9aWv/e3v8ZGf/MzP9KSv9ycv/v7/+MhAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEHAAYALAAAAAAQABAAAAamQEMCMEwYj0hhADAABJDQIwSQkTAAjOGiApUAFgmGpPL4cqHf8Lg8OCO/VmziACBG71HH59JAICh9IikWGA5GJBhGewIoCAIfDRMnRo4JJpcIIwoUFxMfG5QCIR8cGgoaKKccIwKUIAkIFgQTDiIOCiMjF66wJSe0HQoWIh4NRhSvCIkTCgkOHgkjJEYinx8UG34FCBcdJCIJQgQR5CLmIh0nHQThQQA7);
	}
	
	.icon_surrogat_grey { 
		font: 0.75em Geneva, Verdana, sans-serif; 
		border: 1px solid #333; 
		margin-left: 1px !important;
		margin-right: 2px !important;
		padding: 0.1em 0.25em !important;
		background: #FAFAFA; 
		color: #333; 
		text-decoration: none;
		text-align: center;
		margin-top: 10px;
		vertical-align:baseline;
	}
	.icon_surrogat_grey:hover {
		background: #FFF; 
		color: #000; 	
		border-color: #000;
	}
	.icon_surrogat_color { 
		font: 0.75em Geneva, Verdana, sans-serif; 
		border: 1px solid #333; 
		margin-left: 1px !important;
		margin-right: 2px !important;
		padding: 0.1em 0.25em !important;
		background: #FAFAFA; 
		color: #333; 
		background: #D1940C; 
		color: #FFF;
		text-decoration: none;
		text-align: center;
		vertical-align:baseline;
	}
	
	/* 
	hide textual icon replacement 
	texticons are needed for IE 7 or older due to lack of embedded image support
	*/
	.texticon_greyIE,
	.texticon_colorIE 
	{ 
		display:none;
	}
</style>
		
<xsl:text disable-output-escaping="yes"><![CDATA[<!--[if lte IE 7]>
	<script LANGUAGE="Javascript">
		//alert("This browser was identified as IE version lesser or equal 7");
	</script>

	<style type="text/css">
	/* alternate css for IE (due to issues regarding vetical alignment) */
	select { 
		vertical-align: middle; 
	}
	.menuLeft {
		margin-top: 3px; /* workaround for vertical centerign  */
	}

	/* alternate css for IE 5 to 7 (due to lack of support for inline images) */
		
		/* if browser==(IE elt 7) then overwrite stylesheet */
		
		.icon_phone_cell, 
		.icon_phone_mobile,
		.icon_phone_,
		.icon_phone_normal, 
		.icon_phone_placeholder,
		.icon_phone_fax { 
			padding-left: 0px;
		}

		.texticon_greyIE
		{ 
			display: inline;
			font: 9px Geneva, Verdana, sans-serif; 
			padding: 0.1em 0.25em; 
			border: 1px solid #333; 
			margin-left: 2px;
			margin-right: 2px;
			background: #FAFAFA; 
			color: #333; 
			text-decoration: none;
			text-align: center;
			margin-left: 1px;
		}
		
		.texticon_colorIE,
		.texticon_greyIE:hover
		{ 
			display: inline;
			font: 9px Geneva, Verdana, sans-serif; 
			padding: 0.1em 0.25em; 
			border: 1px solid #333; 
			margin-left: 2px;
			margin-right: 2px;
			background: #D1940C; 
			color: #FFF; 
			text-decoration: none;
			text-align: center;
			margin-left: 1px;
		}			

		.icon
		{ 
			display:none;
		}

	</style>
<![endif]-->]]></xsl:text>
	
</head>

<body onLoad="onBodyLoad()">
<!-- menu -->
<div class="menu" id="menu">
	<div class="menuLeft">
		<span class="title" title="adx - addressbook.xml" style="font-family:serif; font-style:italic;">adx</span>
		<a href="http://adx.elektronengehirn.net" title="Goto adx website">v<xsl:value-of select="$adxVersion"/></a>
		<xsl:text> </xsl:text>
<!--
	<span class="title" style="text-align:left; margin-left:5px; color:#333;" title="addressbook.xml website"><a href="http://adx.elektronengehirn.net">adx</a></span>
-->

		<xsl:variable name="contactCount"                 select="count(contact)"/>
		<xsl:variable name="contactCountTagAdxFreqHigh"   select="count(contact[tag='adx:frequency=high'])"/>
		<xsl:variable name="contactCountTagAdxFreqMedium" select="count(contact[ not(tag) or tag='adx:frequency=medium' or tag='adx:frequency=high|medium|low' or not(tag[starts-with(.,'adx:frequency=')]) ])"/>
		<xsl:variable name="contactCountTagAdxFreqLow"    select="count(contact[tag='adx:frequency=low'])"/>
		<xsl:variable name="contactCountTagAdxFreqNone"    select="count(contact[tag='adx:frequency=none'])"/>
		

		<span class="title" title="Grouping entries by tag 'adx:frequency'">
			<xsl:text>Frequency</xsl:text>
			<xsl:if test="boolean($debugMode)=true()">
				<span>
					<xsl:if test="$contactCount != $contactCountTagAdxFreqHigh + $contactCountTagAdxFreqMedium + $contactCountTagAdxFreqLow + $contactCountTagAdxFreqNone">
						<xsl:attribute name="class">error</xsl:attribute>
					</xsl:if>
					<xsl:text>(</xsl:text><xsl:value-of select="$contactCount"/><xsl:text>)</xsl:text>
				</span>
			</xsl:if>
		</span>
		<a href="javascript:toggleElVisibilityById('adx:frequency=high');toggleFreqMenuEntryStyleElById('MenuFreqHi');" title="Show/hide entries with tag 'adx:frequency=high'">
			<span id="MenuFreqHi">
			    <xsl:text>High</xsl:text>
				<xsl:if test="boolean($debugMode)=true()">
					<xsl:text>(</xsl:text><xsl:value-of select="$contactCountTagAdxFreqHigh"/><xsl:text>)</xsl:text>
				</xsl:if>
			</span>
		</a>
		<xsl:text>-</xsl:text>
		<a href="javascript:toggleElVisibilityById('adx:frequency=medium');toggleFreqMenuEntryStyleElById('MenuFreqMed');" title="Show/hide entries with tag 'adx:frequency=medium'">
			<span id="MenuFreqMed">
			    <xsl:text>Medium</xsl:text>
				<xsl:if test="boolean($debugMode)=true()">
					<xsl:text>(</xsl:text><xsl:value-of select="$contactCountTagAdxFreqMedium"/><xsl:text>)</xsl:text>
				</xsl:if>
			</span>
		</a>
		<xsl:text>-</xsl:text>
		<xsl:choose>
			<xsl:when test="$contactCountTagAdxFreqLow > 0">
				<a href="javascript:toggleElVisibilityById('adx:frequency=low');toggleFreqMenuEntryStyleElById('MenuFreqLo');" title="Show/hide entries with tag 'adx:frequency=low'">
					<span id="MenuFreqLo">
						<xsl:text>Low</xsl:text>
						<xsl:if test="boolean($debugMode)=true()">
							<xsl:text>(</xsl:text><xsl:value-of select="$contactCountTagAdxFreqLow"/><xsl:text>)</xsl:text>
						</xsl:if>
					</span>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<span title="No entries found with tag 'adx:frequency=low'">
					<xsl:text> Low</xsl:text>
					<xsl:if test="boolean($debugMode)=true()">
						<xsl:text>(</xsl:text><xsl:value-of select="$contactCountTagAdxFreqLow"/><xsl:text>)</xsl:text>
					</xsl:if>
				</span>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="boolean($debugMode)=true()">
			<xsl:text> - </xsl:text>
			<span title="Only in debug mode: number of entries with tag 'adx:frequency=none' (can not be shown)">
				<xsl:text>None</xsl:text>
				<xsl:if test="boolean($debugMode)=true()">
					<xsl:text>(</xsl:text><xsl:value-of select="$contactCountTagAdxFreqNone"/><xsl:text>)</xsl:text>
				</xsl:if>
			</span>
		</xsl:if>

		<xsl:if test="boolean($debugMode)=true()">
			<span class="title">Settings</span>
			<a href="javascript:saveAdxSettingsButton_OnClick();" title="Apply current settings to URL">Save</a>
		</xsl:if>	
		
		<xsl:if test="boolean($debugMode)=true()">
			<span class="title">Debug</span>
			<a href="javascript:alert('Browser compliance mode: ' + document.compatMode);" title="Show browser compliance mode">compatMode</a>  
		</xsl:if>	

	</div>
	<div class="menuRight">
		<span id="tagSelector" class="tagSelector">
			<span class="title">TagFilter</span>
			<select id="tagDropDownBox" onChange="applyTagFilter(this.options[this.selectedIndex].value)">
				<option value="g">Enable Javascript to use all features of adx</option>
			</select>
		</span>

		<span class="title">Visibility</span>
		<a href="javascript:toggleAllvCardVisibility();" title="Show/hide all details">Details</a>
		<xsl:if test="string-length($headline_text) > 0">
			<xsl:text>-</xsl:text>
			<a href="javascript:toggleElVisibilityById('Header');" title="Show/hide header">Header</a>
		</xsl:if>
		<!--xsl:text>-</xsl:text>
		<a href="javascript:toggleElVisibilityById('FooterSpacer');">Footer</a-->
		<xsl:if test="boolean($birthday_highlightUpcoming_default)=false()">
			<xsl:text>-</xsl:text> 
			<a href="javascript:highlightUpcomingBirthdays();" title="Highlight upcoming birthdays">Birthdays</a>  
		</xsl:if>

		<span class="title">Fontsize</span><a href="javascript:increaseFontSize();" title="Increase font" style="font-size:1.1em">A</a>-<a href="javascript:decreaseFontSize();" title="Decrease font" style="font-size: 0.7em">A</a> 
	</div>
</div>
	
<div id="tagCloud" style="display:none">
<br/>tag<br/>Cloud

</div>	

<div id="main" align="center">
	<table border="0" cellspacing="0" cellpadding="2">
		<thead>
			<tr id="Header">
			  <xsl:if test="boolean($headline_show_default)=false()">
				<xsl:attribute name="style">display:none</xsl:attribute>
			  </xsl:if>
			  <th colspan="3" style="text-align:center">
				<xsl:value-of select="$headline_text"/><xsl:text></xsl:text>
			  </th>
			</tr>
		</thead>
		
		<!--				
		<xsl:for-each select="contact[string-length(@adx:frequency)>3]">
		-->
		<tbody id="adx:frequency=high">
			<xsl:if test="not(contains( $tag_adxFrequency_Show, 'high'))">
				<xsl:attribute name="style">display:none;</xsl:attribute>
			</xsl:if>
			<tr>
				<td class="colName"></td>
				<td class="tdVerticalSeparator">&#160;</td>
				<td></td>
			</tr>				
			<xsl:for-each select="contact[tag='adx:frequency=high']">
				<xsl:sort select="displayname" order="ascending"/>
				<xsl:sort select="nickname"/>
				<xsl:sort select="surname"/>
				<xsl:sort select="forename"/>
				
				<xsl:apply-templates select="."/>					
			</xsl:for-each>
			<tr>
				<td class="colName"></td>
				<td class="tdVerticalSeparator">&#160;</td>
				<td></td>
			</tr>				
		</tbody>

		
		<tbody id="adx:frequency=medium">
			<xsl:if test="not(contains( $tag_adxFrequency_Show, 'medium'))">
				<xsl:attribute name="style">display:none;</xsl:attribute>
			</xsl:if>
			<tr>
				<td class="colName"></td>
				<td class="tdVerticalSeparator">&#160;</td>
				<td></td>
			</tr>				
			<xsl:for-each select="contact[ not(tag) or tag='adx:frequency=medium' or tag='adx:frequency=high|medium|low' or not(tag[starts-with(.,'adx:frequency=')]) ]">
				<xsl:sort select="displayname" order="ascending"/>
				<xsl:sort select="nickname"/>
				<xsl:sort select="surname"/>
				<xsl:sort select="forename"/>
				
				<xsl:apply-templates select="."/>					
			</xsl:for-each>
			<tr>
				<td class="colName"></td>
				<td class="tdVerticalSeparator">&#160;</td>
				<td></td>
			</tr>				
		</tbody>
		
		<tbody id="adx:frequency=low">
			<xsl:if test="not(contains( $tag_adxFrequency_Show, 'low'))">
				<xsl:attribute name="style">display:none;</xsl:attribute>
			</xsl:if>
			<tr>
				<td class="colName"></td>
				<td class="tdVerticalSeparator">&#160;</td>
				<td></td>
			</tr>				
			<xsl:for-each select="contact[tag='adx:frequency=low']">
				<xsl:sort select="displayname" order="ascending"/>
				<xsl:sort select="nickname"/>
				<xsl:sort select="surname"/>
				<xsl:sort select="forename"/>
				
				<xsl:apply-templates select="."/>					
			</xsl:for-each>
			<tr>
				<td class="colName"></td>
				<td class="tdVerticalSeparator">&#160;</td>
				<td></td>
			</tr>				
			<!--tr>
				<td class="colName"></td>
				<td class="tdVerticalSeparator">&#160;</td>
				<td></td>
			</tr-->				
		</tbody>

		<!--tfoot id="FooterSpacer">
			<tr>
				<td class="colName"></td>
				<td class="tdVerticalSeparator">&#160;</td>
				<td></td>
			</tr>
		</tfoot-->
	</table>
<a name="footer"></a>
<!--
	<p>
	<a href="javascript:void(location.href='http://feeds.technorati.com/contacts/'+escape(location.href))">Extract <abbr title="Virtual Card">vCard</abbr> data</a>.<br/>
	Drag this link to the bookmarks bar so you can grab vCard (VCF) data from any website with embedded <abbr title="HTML vCard">hCard</abbr> information.
	</p>
-->
			<!-- show XSL vendor information -->
			<!--
			<xsl:text >XSL Version: </xsl:text>
			<xsl:value-of select = "system-property('xsl:version')" />
			<br/>
			<xsl:text >Vendor: </xsl:text>
			<xsl:value-of select = "system-property('xsl:vendor')" />
			<br/>
			<xsl:text >URL: </xsl:text>
			<a>
			  <xsl:attribute name="href"><xsl:value-of select = "system-property('xsl:vendor-url')" /></xsl:attribute>
			   <xsl:value-of select = "system-property('xsl:vendor-url')" />
			</a>
			-->			
</div>
</body>
</html>
	</xsl:template>





	

<xsl:template name="hCardEntries">
  <!-- Firefox Addons:
	 - Operator: https://addons.mozilla.org/en-US/firefox/addon/4106
	- Tails Export: 
	-->
	
	<!-- Setup variables - BEGIN -->
	<xsl:variable name="_tagValues_temp">
		<xsl:for-each select="tag[starts-with(.,'xfn:rel=')]">
			<xsl:value-of select="substring-after(., 'xfn:rel=')"/><xsl:text> </xsl:text>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="tagValuesXFN" select="normalize-space($_tagValues_temp)"/>
	<xsl:variable name="isPureOrganization" select="concat(forename, surname, middlename, title, org)=org"/>
	<!-- Setup variables - END -->
	
	
	<br/>
	<xsl:choose>	
		<!-- org -->
		<xsl:when test="$isPureOrganization"><!--does not work: xsl:when test="boolean($isPureOrganization)=true()"-->
			<xsl:if test="nickname and not(nickname='')">
				<span class="nickname" title="nickname">
					<xsl:if test="displayname=nickname">
						<xsl:attribute name="style">display:none;</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="nickname"/>
				</span>
				<br/>
			</xsl:if>
			<span class="fn org" title="organization">
				<xsl:value-of select="org"/>
			</span>
		</xsl:when>
		
		<!-- person -->
		<xsl:otherwise>
			<span class="fn" style="display: none;">
				<xsl:choose>
					<xsl:when test="(forename and not(forename='')) or (surname and not(surname=''))">
						<xsl:value-of select="forename"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="surname"/>				
					</xsl:when>
					<xsl:otherwise>
						<span class="error">
						ERROR: Could not build full name of contact
						</span>
					</xsl:otherwise>
				</xsl:choose>
			</span>
			<span class="n">
				<xsl:if test="nickname and not(nickname='')">
					<span class="nickname" title="nickname">
						<xsl:if test="displayname=nickname">
							<xsl:attribute name="style">display:none;</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="nickname"/>
						<br/>
					</span>
				</xsl:if>
				<xsl:if test="title and not(title='')">
					<span class="honorific-prefix" title="honorific-prefix"><xsl:value-of select="title"/></span>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:if test="forename and not(forename='')">
					<span class="given-name" title="forename"><xsl:value-of select="forename"/></span> 
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:if test="middlename and not(middlename='')">
					<span class="additional-name" title="middle name"><xsl:value-of select="middlename"/></span>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:if test="surname and not(surname='')">
					<span class="family-name" title="surname"><xsl:value-of select="surname"/></span>
				</xsl:if>
				<!--span class="honorific-suffix" title="honorific-suffix">M.D.</span-->
			</span>
		</xsl:otherwise>
	</xsl:choose>
	<br/>
	<xsl:text>
	</xsl:text>

	
	
	<!-- adr -->
	<xsl:variable name="showCountry" select="boolean(country and not(country='') and not(country='de' or country='germany' or country='Germany' or country='GERMANY'))"/>
	<a title="Show postal address on map">
		<xsl:attribute name="href"><xsl:value-of select="$map_href"/><xsl:value-of select="street"/>,<xsl:value-of select="postalcode"/>%20<xsl:value-of select="city"/>,<xsl:value-of select="country"/>,(<xsl:value-of select="displayname"/>)</xsl:attribute>
		<span class="adr">
		  <span class="type" style="display: none;">home</span>

		  <xsl:if test="street and not(street='')">
			<span class="street-address"><xsl:value-of select="street"/></span>
			<br/>
		  </xsl:if>			  
		  <xsl:if test="(postalcode and not(postalcode='')) or (city and not(city=''))">
			  <span class="postal-code"><xsl:value-of select="postalcode"/></span>
			  <xsl:text> </xsl:text>
			  <span class="locality"><xsl:value-of select="city"/></span>
			  <br/>
		  </xsl:if>			  
		  <xsl:if test="country and not(country='')">
			  <span class="country-name"  title="country">
				<xsl:if test="not($showCountry)">
				  <xsl:attribute name="style">display:none</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="country"/>
			  </span>
		  </xsl:if>			  
		  <xsl:if test="state and not(state='')">
			<xsl:if test="$showCountry">
			  <xsl:text>, </xsl:text>
			</xsl:if>
			<span class="region"><xsl:value-of select="state"/></span>
		  </xsl:if>
					  
		</span>	
	</a>
	<xsl:if test="$showCountry or (state and not(state=''))">
	  <br/>
	</xsl:if>


	<!-- birthday -->
	<xsl:if test="birthday and not(birthday='') and not(birthday='YYYY-MM-DD')">
		<xsl:variable name="bdayYear"  select="substring(birthday,1,4)"></xsl:variable><!-- YYYY-mm-dd -->
		<xsl:variable name="bdayMonth" select="substring(birthday,6,2)"></xsl:variable><!-- yyyy-MM-dd -->
		<xsl:variable name="bdayDay"   select="substring(birthday,9,2)"></xsl:variable><!-- yyyy-mm-DD -->
		<xsl:choose>
			<xsl:when test="string(number($bdayMonth))='NaN' or number($bdayMonth) &lt; 1 or number($bdayMonth)>12   or   string(number($bdayDay))='NaN' or number($bdayDay) &lt; 1 or number($bdayDay)>31   or   string-length($bdayYear)!=4">
				<span class="error">
				ERROR: Birthday value '<xsl:value-of select="birthday"/>' could not be processed correctly (required format: YYYY-MM-DD) <br/>
				Parsed birthday values: Year='<xsl:value-of select="$bdayYear"/>, Month='<xsl:value-of select="$bdayMonth"/>', Day='<xsl:value-of select="$bdayDay"/>'
				</span>
			</xsl:when>
			
			<xsl:otherwise>
			   <!--
			   Parsed birthday value: Year='<xsl:value-of select="$bdayYear"/>, Month='<xsl:value-of select="$bdayMonth"/>', Day='<xsl:value-of select="$bdayDay"/>'
			   -->
		<span title="birthday">
		  <xsl:attribute name="id"><xsl:call-template name="buildId"><xsl:with-param name="suffix">_birthday</xsl:with-param></xsl:call-template></xsl:attribute>
			<span class="print_ColorBlack">
			<xsl:text>*</xsl:text>
			<abbr class="bday">				
				<xsl:attribute name="title"><xsl:value-of select="birthday"/></xsl:attribute>
						
				<xsl:call-template name="stringReplace">
					<xsl:with-param name="text">
						<xsl:call-template name="stringReplace">
							<xsl:with-param name="text">
								<xsl:call-template name="stringReplace">
									<xsl:with-param name="text" select="$birthday_outputFormat"/>
									<xsl:with-param name="replace" select="'YYYY'"/>
									<xsl:with-param name="with" select="$bdayYear"/>
								</xsl:call-template>
							</xsl:with-param>
							<xsl:with-param name="replace" select="'MM'"/>
							<xsl:with-param name="with" select="$bdayMonth"/>
						</xsl:call-template>
					</xsl:with-param>
					<xsl:with-param name="replace" select="'DD'"/>
					<xsl:with-param name="with" select="$bdayDay"/>
				</xsl:call-template>
				
			</abbr>
			<!--abbr class="bday" title="1942-01-08">January 8, 1942</abbr-->
			</span>
		</span>

			</xsl:otherwise>
		</xsl:choose>
		
		<br/>
	</xsl:if>


	
	<!-- folksonomy -->
	<xsl:if test="tag and tag!=''">
		<div class="tagGroup">
			<xsl:attribute name="id"><xsl:call-template name="buildId"/>_tagGroup</xsl:attribute>
<!--			
		<xsl:for-each select="tag[.!='' and not(starts-with(.,'adx:')) and (not(contains(.,'=')) or substring-after(.,'=')!='')]">
			<xsl:text> </xsl:text>
			<xsl:choose>
				<xsl:when test="string-length($folksonomy_href)>0 and not(starts-with(.,'xfn:rel='))">
					<a title="Tag" class="tag" rel="tag">
						<xsl:attribute name="href">
							<xsl:call-template name="stringReplace">
								<xsl:with-param name="text" select="$folksonomy_href"/>
								<xsl:with-param name="replace" select="'${tag}'"/>
								<xsl:with-param name="with" select="."/>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:value-of select="."/>										
					</a>			 
				</xsl:when>
				<xsl:otherwise>
					<a class="tag" rel="tag">					
						<xsl:attribute name="href">http://adx.elektronengehirn.net/tags/<xsl:value-of select="."/></xsl:attribute>
						<xsl:attribute name="onClick">toggleTag('<xsl:value-of select="."/>');return false;</xsl:attribute>
						<xsl:attribute name="title">
							<xsl:choose>
								<xsl:when test="starts-with(.,'xfn:rel=')">XFN tag (XHTML Friends Network relationship)</xsl:when>
								<xsl:otherwise>Tag</xsl:otherwise>
							</xsl:choose>								
						</xsl:attribute>
						<xsl:value-of select="."/>
					</a>			 
				</xsl:otherwise>
			</xsl:choose>				
		</xsl:for-each> 
-->
		</div>
	</xsl:if>
	
	<xsl:text>
	</xsl:text>

	
	<xsl:for-each select="email[not(.='')]">				
	  <a class="email" title="email">
		<xsl:attribute name="href">mailto:<xsl:value-of select="."/></xsl:attribute>		
		<xsl:if test="$tagValuesXFN != ''"><xsl:attribute name="rel"><xsl:value-of select="$tagValuesXFN"/></xsl:attribute></xsl:if>

		<xsl:if test="@type and not(@type='')"><span class="type" style="display: none;"><xsl:value-of select="@type"/></span></xsl:if>
		<xsl:if test="@use and not(@use='')"><span class="type" style="display: none;"><xsl:value-of select="@use"/></span></xsl:if>
		<span class="value"><xsl:value-of select="."/></span>
	  </a>
	  <br/>
	  <xsl:text>
	  </xsl:text>
	</xsl:for-each>
	
	<xsl:apply-templates select="website[normalize-space(.)!='' and not(@type='work')]"/>

	<xsl:for-each select="misc[normalize-space(.)!='']">
		<span>
			<xsl:attribute name="title">
				<xsl:choose>
					<xsl:when test="@type and @type!=''">
						<xsl:value-of select="@type"/>
					</xsl:when>
					<xsl:otherwise>miscellaneous</xsl:otherwise>
				</xsl:choose>		
			</xsl:attribute>		  
			<xsl:value-of select="."/>
		</span>
		<br/>
		<xsl:text>
		</xsl:text>
	</xsl:for-each>
	

	
	<xsl:if test="count(account[not(.='')]) > 0">
		<div class="iconGroup">
		<xsl:text>&#160;</xsl:text><!-- Fix for Safari (3.2.2). If no text is in line the account icons are not shown. -->
		<xsl:for-each select="account[not(.='')]">
		  <xsl:variable name="accountTypeLowerCase" select="translate(@type,$upper,$lower)"/>
		  <xsl:choose>

			<xsl:when test="$accountTypeLowerCase='8tracks'"><!-- no icon -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">8tracks</xsl:with-param>
					<xsl:with-param name="linkHref">http://8tracks.com/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">8tracks profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='aim'"><!-- no icon -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">AIM</xsl:with-param>
					<xsl:with-param name="linkHref">aim:goim?screenname=<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">Chat via AOL Instant Messenger (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>			
			</xsl:when>

			<xsl:when test="$accountTypeLowerCase='amiestreet'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">amiestreet</xsl:with-param>
					<xsl:with-param name="linkHref">http://amiestreet.com/user/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">amiestreet profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="$accountTypeLowerCase='bebo'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">bebo</xsl:with-param>
					<xsl:with-param name="linkHref">
						<xsl:choose>
							<xsl:when test="string(number(.))='NaN'">
								<xsl:text>http://www.bebo.com/</xsl:text><!-- if user name is used e.g. bartensud -->
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>http://www.bebo.com/Profile.jsp?MemberId=</xsl:text><!-- if member id is used (can be taken from your profile url, e.g. http://www.bebo.com/Profile.jsp?MemberId=9486378706) -->
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="."/>
					</xsl:with-param>
					<xsl:with-param name="linkTitle">bebo profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='brightkite'"><!-- no icon -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">brightkite</xsl:with-param>
					<xsl:with-param name="linkHref">http://brightkite.com/people/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">brightkite profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:when>	
			
			<xsl:when test="$accountTypeLowerCase='cliqset'"><!-- icon missing -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">cliqset</xsl:with-param>
					<xsl:with-param name="linkHref">http://<xsl:value-of select="."/>.cliqset.net</xsl:with-param>
					<xsl:with-param name="linkTitle">cliqset.net profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			
			
			<xsl:when test="$accountTypeLowerCase='delicious'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">Delicious</xsl:with-param>
					<xsl:with-param name="linkHref">http://delicious.com/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">delicious profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">delicious</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			
			
			<xsl:when test="$accountTypeLowerCase='deviantart'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">DeviantArt</xsl:with-param>
					<xsl:with-param name="linkHref">http://<xsl:value-of select="."/>.deviantart.com/</xsl:with-param>
					<xsl:with-param name="linkTitle">DeviantArt.com profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">deviantart</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>						

			<xsl:when test="$accountTypeLowerCase='digg'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">digg</xsl:with-param>
					<xsl:with-param name="linkHref">http://digg.com/users/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">digg.com profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">digg</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='dopplr'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">dopplr</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.dopplr.com/traveller/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">dopplr.com profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">dopplr</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='ebay'"><!-- icon missing -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">ebay</xsl:with-param>
					<xsl:with-param name="linkHref">http://myworld.ebay.com/<xsl:value-of select="."/></xsl:with-param><!-- use ebay user id -->
					<xsl:with-param name="linkTitle">ebay profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='facebook'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">Facebook</xsl:with-param>
					<xsl:with-param name="linkHref">
						<xsl:choose>
							<xsl:when test="contains(., '/')">
								<xsl:text>http://www.facebook.com/people/</xsl:text><!-- automatic created user, e.g. "John-Smith/1666061639" -->
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>http://www.facebook.com/</xsl:text><!-- Facebook username (which can be set in facebook account settings once) -->
							</xsl:otherwise>
							<!--xsl:otherwise>
								<xsl:text>http://profile.to/</xsl:text><!- this name is the "Facebook profile webaddress" and must be created manually by user, e.g. "barackobama"- - >
							</xsl:otherwise-->
						</xsl:choose>
						<xsl:value-of select="."/>
					</xsl:with-param>
					<xsl:with-param name="linkTitle">Facebook profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">facebook</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			
			
			<xsl:when test="$accountTypeLowerCase='flickr'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">Flickr</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.flickr.com/people/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">Flickr profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">flickr</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='foursquare'"><!-- no icon -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">foursquare</xsl:with-param>
					<xsl:with-param name="linkHref">http://foursquare.com/user/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">foursquare profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="$accountTypeLowerCase='friendster'"><!-- icons in need -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">Friendster</xsl:with-param>
					<xsl:with-param name="linkHref">http://profiles.friendster.com/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">Friendster profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='google'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">Google</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.google.com/profiles/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">Google profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">google</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			
			
			<xsl:when test="$accountTypeLowerCase='googlecode'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">GoogleCode</xsl:with-param>
					<xsl:with-param name="linkHref">http://code.google.com/u/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">GoogleCode profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">google</xsl:with-param>
				</xsl:call-template>
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='gowalla'"><!-- no icon -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">Gowalla</xsl:with-param>
					<xsl:with-param name="linkHref">http://gowalla.com/users/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">Gowalla profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="$accountTypeLowerCase='hellotxt'"><!-- no icon -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">hellotxt</xsl:with-param>
					<xsl:with-param name="linkHref">http://hellotxt.com/user/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">hellotxt profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="$accountTypeLowerCase='huffduffer'"><!-- no icon -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">huffduffer</xsl:with-param>
					<xsl:with-param name="linkHref">http://huffduffer.com/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">huffduffer profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="$accountTypeLowerCase='hi5'"><!-- no icon -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">hi5</xsl:with-param>
					<xsl:with-param name="linkHref">http://<xsl:value-of select="."/>.hi5.com</xsl:with-param>
					<xsl:with-param name="linkTitle">hi5 profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="$accountTypeLowerCase='icq'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">ICQ</xsl:with-param>
					<xsl:with-param name="linkHref">http://people.icq.com/people/about_me.php?uin=<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">ICQ profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">icq</xsl:with-param>
				</xsl:call-template>
					<!-- see: http://www.icq.com/features/web/indicator.html -->
					<!--img alt="ICQ" style="border: none;">
						<xsl:attribute name="src">http://web.icq.com/whitepages/online?icq=<xsl:value-of select="."/>&amp;img=5</xsl:attribute>
					</img-->
			  <!-- get in contact -->
			  <!--a class="url" type="application/x-icq">
				<xsl:attribute name="title">ICQ: Contact <xsl:value-of select="."/></xsl:attribute>
				<xsl:attribute name="href">http://www.icq.com/people/cmd.php?uin=<xsl:value-of select="."/>&amp;action=message</xsl:attribute>
					Contact
					<span>
					  <xsl:attribute name="class">icon_icq_<xsl:value-of select="$accountIcons_colorStyle"/></xsl:attribute>
					</span>
			  </a-->
			</xsl:when>
			
			<xsl:when test="$accountTypeLowerCase='jappy.de'"><!-- icon missing -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">jappy</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.jappy.de/user/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">jappy.de profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			
			
			<xsl:when test="$accountTypeLowerCase='last.fm'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">last.fm</xsl:with-param>
					<xsl:with-param name="linkHref">http://last.fm/user/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">last.fm profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">lastfm</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="$accountTypeLowerCase='digg'"><!-- icon missing -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">digg</xsl:with-param>
					<xsl:with-param name="linkHref">http://digg.com/users/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">digg.com profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='hypem.com'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">hypem</xsl:with-param>
					<xsl:with-param name="linkHref">http://hypem.com/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">The Hype Machine profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">hypem</xsl:with-param>
				</xsl:call-template>			  
			</xsl:when>			
			
			<xsl:when test="$accountTypeLowerCase='identi.ca'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">identi.ca</xsl:with-param>
					<xsl:with-param name="linkHref">http://identi.ca/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">identi.ca (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">identica</xsl:with-param>
				</xsl:call-template>			  
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='lokalisten.de'"><!-- icon missing -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">lokalisten</xsl:with-param>
					<xsl:with-param name="linkHref">
						<xsl:choose>
							<xsl:when test="not(string(number(.))='NaN')"><!-- isNumber? -->
								<xsl:text>http://www.lokalisten.de/web/showuser/showProfile.do?accountId=</xsl:text><!-- via profile key for logged on users(http://www.lokalisten.de/web/showuser/showProfile.do?accountId=<profileKey>) e.g. "4002442" results in http://www.lokalisten.de/web/showuser/showProfile.do?accountId=4002442 -->
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>http://www.lokalisten.de/id/</xsl:text><!-- you must enable your lokalisten-id to get a public profile site (in info/privatsphäre) -->
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="."/>
					</xsl:with-param>
					<xsl:with-param name="linkTitle">lokalisten.de profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			
			

			<xsl:when test="$accountTypeLowerCase='linkedin'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">LinkedIn</xsl:with-param>
					<xsl:with-param name="linkHref">
						<xsl:choose>
							<xsl:when test="contains(., '/')">
								<xsl:text>http://www.linkedin.com/pub/</xsl:text><!-- e.g. "7/270/925"  results in http://www.linkedin.com/pub/7/270/925-->
							</xsl:when>
							<xsl:when test="not(string(number(.))='NaN')">
								<xsl:text>https://www.linkedin.com/e/fpf/</xsl:text><!-- via profile key (https://www.linkedin.com/profile?viewProfile=&key=<profileKey>) e.g. "11932467" results in https://www.linkedin.com/e/fpf/11932467 -->
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>http://www.linkedin.com/in/</xsl:text><!-- default: public profile url,  e.g. "barackobama" results in http://www.linkedin.com/in/barackobama-->
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="."/>
					</xsl:with-param>
					<xsl:with-param name="linkTitle">LinkedIn profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">linkedin</xsl:with-param>
				</xsl:call-template>
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='msnim'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">MSNIM</xsl:with-param>
					<xsl:with-param name="linkHref">msnim:chat?contact=<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">Chat via MSN Instant Messenger (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">msnim</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="$accountTypeLowerCase='myspace'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">MySpace</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.myspace.com/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">MySpace profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">myspace</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="$accountTypeLowerCase='ohloh'"><!-- icon missing -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">ohloh</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.ohloh.net/accounts/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">ohloh.net profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='my.opera.com'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">Opera</xsl:with-param>
					<xsl:with-param name="linkHref">http://my.opera.com/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">my.opera.com profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			
			
			<xsl:when test="$accountTypeLowerCase='orkut'"><!-- icon missing -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">Orkut</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.orkut.com/Profile.aspx?uid=<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">Orkut.com profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='picasa'"><!-- icon missing -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">Picasa</xsl:with-param>
					<xsl:with-param name="linkHref">http://picasaweb.google.com/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">Picasa profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='quarterlife'"><!-- no icon -->
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">ql</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.quarterlife.com/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">quarterlife profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:when>	

			<xsl:when test="$accountTypeLowerCase='qype'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">Qype</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.qype.com/people/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">Qype profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='rememberthemilk' or $accountTypeLowerCase='rmilk'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">rmilk</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.rememberthemilk.com/home/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">Remember the milk profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='schuelervz'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">schülerVZ</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.schuelervz.net/Profile/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">schülerVZ profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">schuelervz</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="$accountTypeLowerCase='skype'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">Skype</xsl:with-param>
					<xsl:with-param name="linkHref">skype:<xsl:value-of select="."/>?userinfo</xsl:with-param>
					<xsl:with-param name="linkTitle">Skype profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">skype</xsl:with-param>
				</xsl:call-template>
				<!--img alt="Skype" style="border: none;">
				  <xsl:attribute name="src">Skype16x16_grey.png</xsl:attribute>
				</img-->

				<!-- Show skype online status (must be enabled in preferences by skype user): http://www.skype.com/intl/en/share/buttons/ -->
				<!--
				<img style="border: none;" width="150" height="60" alt="My status">
				  <xsl:attribute name="src">http://mystatus.skype.com/balloon/<xsl:value-of select="."/></xsl:attribute>
				</img>
				-->
			</xsl:when>
		  
			<xsl:when test="$accountTypeLowerCase='sourceforge'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">SourceForge</xsl:with-param>
					<xsl:with-param name="linkHref">http://sourceforge.net/users/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">SourceForge profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">sourceforge</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="starts-with($accountTypeLowerCase,'soup')">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">Soup</xsl:with-param>
					<xsl:with-param name="linkHref">http://<xsl:value-of select="."/>.soup.io</xsl:with-param>
					<xsl:with-param name="linkTitle">Soup profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">soup</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='spin.de'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">spin.de</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.spin.de/hp/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">Spin.de profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">spinde</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="$accountTypeLowerCase='studivz'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">studiVZ</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.studivz.net/Profile/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">studiVZ profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">studivz</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="$accountTypeLowerCase='technorati'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">technorati</xsl:with-param>
					<xsl:with-param name="linkHref">http://technorati.com/people/technorati/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">Technorati.com (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>			  
			</xsl:when>			
			
			<xsl:when test="$accountTypeLowerCase='twitter'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">twitter</xsl:with-param>
					<xsl:with-param name="linkHref">http://twitter.com/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">Twitter (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">twitter</xsl:with-param>
				</xsl:call-template>			  
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='viadeo'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">viadeo</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.viadeo.com/recherche/profil/?memberId=<xsl:value-of select="."/></xsl:with-param><!-- e.g. http://www.viadeo.com/recherche/profil/?memberId=0021288l806v8nl -->
					<xsl:with-param name="linkTitle">viadeo profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='vimeo'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">vimeo</xsl:with-param>
					<xsl:with-param name="linkHref">http://vimeo.com/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">vimeo profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">vimeo</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='werkenntwen'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">wkw</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.wer-kennt-wen.de/person/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">wer-kennt-wen profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>	  
			</xsl:when>			

			<xsl:when test="$accountTypeLowerCase='xing'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">XING</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.xing.com/profile/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">Xing profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">xing</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			
			<xsl:when test="$accountTypeLowerCase='xmpp' or $accountTypeLowerCase='jabber'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">Jabber</xsl:with-param>
					<xsl:with-param name="linkHref">xmpp:<xsl:value-of select="."/>@jabberservice.com</xsl:with-param>
					<xsl:with-param name="linkTitle">Jabber (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:when>			
			
			<xsl:when test="$accountTypeLowerCase='yim'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">YIM</xsl:with-param>
					<xsl:with-param name="linkHref">ymsgr:sendIM?<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">Chat via Yahoo Instant Messenger (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">yim</xsl:with-param>
				</xsl:call-template>
			</xsl:when>			
		
			<xsl:when test="$accountTypeLowerCase='youtube'">
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName">YouTube</xsl:with-param>
					<xsl:with-param name="linkHref">http://www.youtube.com/user/<xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">YouTube profile (<xsl:value-of select="."/>)</xsl:with-param>
					<xsl:with-param name="cssClass">youtube</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<xsl:otherwise>
				<xsl:call-template name="buildAccountIcon">
					<xsl:with-param name="AlternativeDisplayName"><xsl:value-of select="@type"/></xsl:with-param>
					<xsl:with-param name="linkHref"><xsl:value-of select="."/></xsl:with-param>
					<xsl:with-param name="linkTitle">Generic account type '<xsl:value-of select="@type"/>'</xsl:with-param>
					<xsl:with-param name="cssClass">surrogat</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		  </xsl:choose>
		<!--xsl:text>
		</xsl:text-->
		</xsl:for-each>
		
		</div>
	</xsl:if>


	  
	<!-- Geo information[latitude;longitude]-->
	<!--xsl:if test="geo and contains(geo, ';')  and  not(contains(geo,'a') or contains(geo,'b') or contains(geo,'x') or contains(geo,'y'))">
		[Locations]
		<br/>
	</xsl:if-->
	<xsl:for-each select="geo">
	  <xsl:if test="contains(., ';')  and  not(contains(.,'a') or contains(.,'b') or contains(.,'x') or contains(.,'y'))">
		<!--abbr class="geo">
			<xsl:attribute name="title"><xsl:value-of select="geo"/></xsl:attribute>
			<xsl:text>Geo cooridnates</xsl:text>
		</abbr-->
		<xsl:variable name="latitude" select="substring-before(.,';')"/>
		<xsl:variable name="longitude" select="substring-after(.,';')"/>
		<a class="geo">
			<xsl:attribute name="href"><xsl:value-of select="$map_href"/><xsl:value-of select="$latitude"/>,<xsl:value-of select="$longitude"/></xsl:attribute>
			<xsl:attribute name="title">Show on map</xsl:attribute>
			<xsl:text>Geo: </xsl:text>
			<xsl:choose>
				<xsl:when test="@name and not(@name='')">
					<xsl:value-of select="@name"/>
				</xsl:when>
				<xsl:otherwise>
					<span title="latitude"><xsl:value-of select="$latitude"/></span>;<span title="longitude"><xsl:value-of select="$longitude"/></span>
				</xsl:otherwise>
			</xsl:choose>
			
			<!-- geo microformat values (hidden) -->
			<span style="display: none">
				<abbr class="latitude" >
					<xsl:attribute name="title"><xsl:value-of select="$latitude"/></xsl:attribute>
					<xsl:value-of select="$latitude"/>
				</abbr>
				<abbr class="longitude" >
					<xsl:attribute name="title"><xsl:value-of select="$longitude"/></xsl:attribute>
					<xsl:value-of select="$longitude"/>
				</abbr>				
			</span>
			<xsl:text></xsl:text>
		</a>
		<br/>
	  </xsl:if>
	</xsl:for-each>	  
	
	<!-- org  (if contact is about a person, not a organization) -->
	<xsl:if test="$isPureOrganization=false() and ( org and ( not(org='')  or  (org[@idref and not(@idref='')]) ) )">
		<xsl:variable name="orgName">
			<xsl:choose>
				<xsl:when test="not(org='')">
					<xsl:value-of select="org"/>
				</xsl:when>
				
				<xsl:when test="org[@idref and not(@idref='')]">
					<xsl:call-template name="buildActualDisplayName"><!-- works only when DTD with id and idref is defined -->
						<xsl:with-param name="contactNode" select="id(org/@idref)"/>
					</xsl:call-template>
				</xsl:when>
				
				<xsl:otherwise>organization</xsl:otherwise>
			</xsl:choose>				
		</xsl:variable>
		<span class="org" title="organization name">
			<xsl:choose>
				<xsl:when test="org[@idref and not(@idref='')]">
					<a href="#{org/@idref}">
						<xsl:value-of select="$orgName"/>
					</a>			 
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$orgName"/>
				</xsl:otherwise>
			</xsl:choose>				
		</span>
		<br/>
	</xsl:if>
	<xsl:apply-templates select="website[@type='work' and not(.='')]"/>
	<xsl:if test="orgunit and not(orgunit='')">
		<span class="org-unit" title="organization unit"><xsl:value-of select="orgunit"/></span><!-- class name for hCard !?!?!?!?!?!?!? -->
		<br/>
	</xsl:if>			  
	<xsl:if test="position and not(position='')">
		<span class="title" title="position in organization"><xsl:value-of select="position"/></span>
		<br/>
	</xsl:if>			  

	
	<xsl:text>
	</xsl:text>		
</xsl:template>

	
<xsl:template match="contact">	
	<xsl:variable name="contactId"><xsl:call-template name="buildId"/></xsl:variable>
	<tr class="vcard" id="{$contactId}">
		<td>			
		<div class="colName">
			<xsl:if test="@id">
				<a name="{@id}"/>
			</xsl:if>
			 <!--
						 <xsl:choose>
							<xsl:when test="birthday and not(birthday='')">
								<xsl:attribute name="title">*<xsl:value-of select="birthday"/></xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
							 
							</xsl:otherwise>
						 </xsl:choose>
						 -->
				<a class="vCardHeader" href="#">
					<xsl:attribute name="onclick">toggleVCardDetailVisibility('<xsl:value-of select="$contactId"/>');return false;</xsl:attribute>
					<xsl:attribute name="title">
						<xsl:choose>
							<xsl:when test="$debugMode=true()"><xsl:value-of select="$contactId"/></xsl:when>
							<xsl:otherwise>Show details</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>

					<span>
						<xsl:attribute name="class">print_ColorBlack</xsl:attribute><!-- For UNmarking selected names when printing-->
						<xsl:call-template name="buildActualDisplayName"/>
					</span>
				</a>

		  <span class="vCardBodyLeft">
			<xsl:if test="not($details_show_default)">
				<xsl:attribute name="style">display: none;</xsl:attribute>
			</xsl:if>
			<xsl:call-template name="hCardEntries"/>
		  </span>
		</div>
		</td>

		<td class="tdVerticalSeparator">&#160;</td>
		<td>
			<div class="vCardBodyRight">
				<xsl:for-each select="phone">				
					<xsl:apply-templates select="."/>
				</xsl:for-each>
			</div>
		</td>
	</tr>
</xsl:template>



<xsl:template match="phone">
	<xsl:if test="not(.='')"><!-- and not(@type='fax')"-->
		<span class="tel">
			<xsl:attribute name="title"><xsl:value-of select="normalize-space(concat(@use, ' ', @type))"/></xsl:attribute>
			
			<xsl:if test="boolean($phone_showIcons)=true()">
				<span>
					<xsl:choose>
						<xsl:when test="not(@type) or @type='cell' or @type='mobile' or @type='normal'">
							<xsl:attribute name="class">icon_phone_<xsl:value-of select="@type"/></xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">icon_phone_placeholder</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
				</span>
			</xsl:if>
			
			<!-- value-title-pattern-->
			<xsl:if test="@type and not(@type='')">
			  <span class="type">
				<span class='value-title'> 
					<xsl:attribute name="title">
						<xsl:call-template name="stringReplace">
							<xsl:with-param name="text" select="@type"/>
							<xsl:with-param name="replace" select="'mobile'"/>
							<xsl:with-param name="with" select="'cell'"/>
						</xsl:call-template>
					</xsl:attribute>
				</span>
			  </span>
			</xsl:if>
			<xsl:if test="@use and not(@use='')"><span class="type"><span class='value-title' title="{@use}"></span></span></xsl:if>

			<xsl:variable name="intFormattedPhoneNr">
				<xsl:choose>
					<xsl:when test="$phone_internationalAreaCode_default and substring(.,1,1)='0'"><xsl:value-of select="$phone_internationalAreaCode_default"/><xsl:value-of select="substring(translate(.,' -/',''),2)"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="translate(., ' -/', '')"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>				
			<a class="value" href="callto:{$intFormattedPhoneNr}"><!-- value-class-pattern -->
					<xsl:value-of select="."/>
			</a>
			<br/>
		</span>
		<xsl:text>
		</xsl:text>
	</xsl:if>
</xsl:template>

	
<xsl:template match="website">
	<!-- Get XFN tag values (seems not possible to externalize in a template due to tree-fragment limitation for passing a node-set via xsl:param -->
	<xsl:variable name="_tagValues_TEMP">
		<xsl:for-each select="..//tag[starts-with(.,'xfn:rel=')]">
			<xsl:value-of select="substring-after(., 'xfn:rel=')"/><xsl:text> </xsl:text>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="tagValuesXFN" select="normalize-space($_tagValues_TEMP)"/>


	<a class="url" title="URL {@type}">
		<xsl:attribute name="href"><xsl:if test="not(contains(. ,':'))">http://</xsl:if><xsl:value-of select="."/></xsl:attribute>		  
		<xsl:if test="string-length($tagValuesXFN) > 0">
			<xsl:attribute name="rel"><xsl:value-of select="$tagValuesXFN"/></xsl:attribute>
		</xsl:if>
		<xsl:if test="@type and not(@type='')"><span class="type" style="display: none;"><xsl:value-of select="@type"/></span></xsl:if>
		<!--span class="value"-->
			<xsl:choose>
				<xsl:when test="@display and not(@display='')">
					<xsl:value-of select="@display"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		<!--/span-->		
	</a>			  
	<br/>
	<xsl:text>
	</xsl:text>
</xsl:template>

<xsl:template name="buildActualDisplayName">
	<xsl:param name="contactNode" select="."/>
	
	<xsl:choose>
		<xsl:when test="$contactNode/displayname and not($contactNode/displayname='')">
			<xsl:apply-templates select="$contactNode/displayname"/>
		</xsl:when>

		<xsl:when test="$contactNode/nickname and not($contactNode/nickname='')">
			<xsl:apply-templates select="$contactNode/nickname"/>
		</xsl:when>

		<xsl:when test="$contactNode/forename and $contactNode/surname and not($contactNode/forename='') and not($contactNode/surname='')">
			<xsl:apply-templates select="$contactNode/surname"/><xsl:text>&#160;</xsl:text><xsl:apply-templates select="$contactNode/forename"/>
		</xsl:when>
	   
		<xsl:when test="$contactNode/forename and not($contactNode/forename='')">
			<xsl:apply-templates select="$contactNode/forename"/>
		</xsl:when>
	   
		<xsl:when test="$contactNode/forename and not($contactNode/surname='')">
			<xsl:apply-templates select="$contactNode/surname"/>
		</xsl:when>

		<!-- org -->
		<xsl:when test="$contactNode/org and not($contactNode/org='')">
			<xsl:apply-templates select="$contactNode/org"/>
		</xsl:when>   
		<!--xsl:when test="$contactNode/@type='company'">
			<xsl:apply-templates select="company"/>							 	
		</xsl:when-->
		
		<xsl:otherwise>							 	 
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
	
	
<!--		
	<xsl:template match="forename">
		<xsl:if test="../nickname=''">
			<xsl:value-of select="."/><xsl:text>&#160;</xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="surname">
		<xsl:if test="../nickname=''">
			<xsl:value-of select="."/>
		</xsl:if>
	</xsl:template>

	
	<xsl:template match="nickname">
		<xsl:if test="not(.='')">
		<span>
			<xsl:attribute name="title"><xsl:value-of select="../forename"/>&#160;<xsl:value-of select="../surname"/></xsl:attribute>
			<xsl:value-of select="."/>
		</span>
		</xsl:if>
	</xsl:template>
	<xsl:template match="*">
	</xsl:template>
-->		
</xsl:stylesheet>
