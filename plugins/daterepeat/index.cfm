<h1>DateRepeat v0.1</h1>
<p>DateRepeat provides some logic to calculate repeating event dates via the <code>repeatDate()</code> function.</p>

<p>For examples, see the unit tests;</p>

<h3>Repeat Types </h3>
<p>Repeats can be</p>
<ul> 
<li>daily - i.e, every day</li>
<li>weekday - i.e, every weekday</li>
<li>mwf - i.e, every mon/weds/fri</li>
<li>tt - i.e every tue/thurs</li>
<li>ss - i.e every sat/sun</li>
<li>weekly - i.e, same day every week</li>
<li>weeklyDOW - i.e, every week on these days</li>
<li>monthly - i.e, every month on this Day of the Month, like the 10th of each month</li>
<li>monthlyDOW - i.e, every month on this Day of the Week, like the 1st Tuesday of each month</li>
<li>yearly - i.e, every year on this day</li></ul>
<p>Repeats can be generated via a simple loop, i.e, 'x' times using the iteration=10 argument</p>
<p>Repeats can also be generated via a start and end date, i.e, as many times as need from DateA to DateB</p>
<p>