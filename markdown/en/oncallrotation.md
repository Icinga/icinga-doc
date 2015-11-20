[Prev](escalation_condition.md) ![Icinga](../images/logofullsize.png "Icinga") [Next](clusters.md)

* * * * *

7.11. On-Call Rotations
-----------------------

7.11.1. [Introduction](oncallrotation.md#introduction)

7.11.2. [Scenario 1: Holidays and
Weekends](oncallrotation.md#holidaysweekends)

7.11.3. [Scenario 2: Alternating
Days](oncallrotation.md#alternatingdays)

7.11.4. [Scenario 3: Alternating
Weeks](oncallrotation.md#alternatingweeks)

7.11.5. [Scenario 4: Vacation Days](oncallrotation.md#vacationdays)

7.11.6. [Other Scenarios](oncallrotation.md#others)

### 7.11.1. Introduction

![](../images/objects-contacts.png)
![](../images/objects-timeperiods.png)

Admins often have to shoulder the burden of answering pagers, cell phone
calls, etc. when they least desire them. No one likes to be woken up at
4 am to fix a problem. But its often better to fix the problem in the
middle of the night, rather than face the wrath of an unhappy boss when
you stroll in at 9 am the next morning.

For those lucky admins who have a team of gurus who can help share the
responsibility of answering alerts, on-call rotations are often setup.
Multiple admins will often alternate taking notifications on weekends,
weeknights, holidays, etc.

We'll show you how you can create
[timeperiod](timeperiods.md "5.9. Time Periods") definitions in a way
that can facilitate most on-call notification rotations. These
definitions won't handle human issues that will inevitably crop up
(admins calling in sick, swapping shifts, or throwing their pagers into
the river), but they will allow you to setup a basic structure that
should work the majority of the time.

### 7.11.2. Scenario 1: Holidays and Weekends

alerts. John receives all notifications for weekdays (with 24 hour
days), excluding holidays; Bob handles notifications during the weekends
and holidays. Lucky Bob. Here's how you can define this type of rotation
using timeperiods...

First, define 3 timeperiods that contains time ranges for holidays,
weekdays, and weekends:

<pre><code>
 define timeperiod{
 define timeperiod{

 define timeperiod{
</code></pre>

Next, define a timeperiod for John's on-call times that include
weekdays, but excludes the dates/times defined in the holidays
timeperiod above:

<pre><code>
 define timeperiod{
</code></pre>

You can now reference this timeperiod in John's contact definition:

<pre><code>
 define contact{
</code></pre>

Define a new timeperiod for Bob's on-call times that include weekends
and the dates/times defined in the holidays timeperiod above:

<pre><code>
 define timeperiod{
</code></pre>

You can now reference this timeperiod in Bob's contact definition:

<pre><code>
 define contact{
</code></pre>

### 7.11.3. Scenario 2: Alternating Days

In this scenario John and Bob alternate handling alerts every other day
- regardless of whether its a weekend, weekday, or holiday.

Define a timeperiod for when John should receive notifications. Assuming
today's date is August 1st, 2007 and John is handling notifications
starting today, the definition would look like this:

<pre><code>
 define timeperiod{
</code></pre>

Now define a timeperiod for when Bob should receive notifications. Bob
gets notifications on the days that John doesn't, so his first on-call
day starts tomorrow (August 2nd, 2007).

<pre><code>
 define timeperiod{
</code></pre>

Now you need to reference these timeperiod definitions in the contact
definitions for John and Bob:

<pre><code>
 define contact{
</code></pre>

<pre><code>
 define contact{
</code></pre>

### 7.11.4. Scenario 3: Alternating Weeks

In this scenario John and Bob alternate handling alerts every other
week. John handles alerts Sunday through Saturday one week, and Bob
handles alerts for the following seven days. This continues in
perpetuity.

Define a timeperiod for when John should receive notifications. Assuming
today's date is Sunday, July 29th, 2007 and John is handling
notifications this week (starting today), the definition would look like
this:

<pre><code>
 define timeperiod{
</code></pre>

Now define a timeperiod for when Bob should receive notifications. Bob
gets notifications on the weeks that John doesn't, so his first on-call
day starts next Sunday (August 5th, 2007).

<pre><code>
 define timeperiod{
</code></pre>

Now you need to reference these timeperiod definitions in the contact
definitions for John and Bob:

<pre><code>
 define contact{
</code></pre>

<pre><code>
 define contact{
</code></pre>

### 7.11.5. Scenario 4: Vacation Days

In this scenarios, John handles notifications for all days except those
he has off. He has several standing days off each month, as well as some
planned vacations. Bob handles notifications when John is on vacation or
out of the office.

First, define a timeperiod that contains time ranges for John's vacation
days and days off:

<pre><code>
 define timeperiod{
</code></pre>

Next, define a timeperiod for John's on-call times that excludes the
dates/times defined in the timeperiod above:

<pre><code>
 define timeperiod{
</code></pre>

You can now reference this timeperiod in John's contact definition:

<pre><code>
 define contact{
</code></pre>

Define a new timeperiod for Bob's on-call times that include the
dates/times that John is out of the office:

<pre><code>
 define timeperiod{
</code></pre>

You can now reference this timeperiod in Bob's contact definition:

<pre><code>
 define contact{
</code></pre>

### 7.11.6. Other Scenarios

There are a lot of other on-call notification rotation scenarios that
you might have. The date exception directive in [timeperiod
definitions](objectdefinitions.md#objectdefinitions-timeperiod) is
capable of handling most dates and date ranges that you might need to
use, so check out the different formats that you can use. If you make a
mistake when creating timeperiod definitions, always err on the side of
giving someone else more on-call duty time. :-)

* * * * *

[Prev](escalation_condition.md) | [Up](ch07.md) | [Next](clusters.md)






© 1999-2009 Ethan Galstad, 2009-2015 Icinga Development Team,
http://www.icinga.org
