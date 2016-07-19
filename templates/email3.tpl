<table border="0" width="100%">
    <tr>
        <td style="width:50%; text-align: left">
            <img width="179" height="100" border="0" alt="Voice of America Logo" title="Voice of America" src="voa-logo.jpg" />
        </td>
        <td style="width:50%; text-align: left">
            <strong style="font-family:Calibri; font-size:15px">VOA Studio Tour</strong><br/>
            <strong style="font-family:Calibri; font-size:15px">Sign-up Sheet</strong>
        </td>
    </tr>
</table>


<strong><p style="font-family:Calibri; font-size:15px">
Date: {$reservation.tour_date|date_format:"M d, Y"}<br/>
Time: {if $reservation.type_of_tour == "Daily"}12:00 p.m.{else}_________{/if}</p></strong>

<h3 style="font-family:Calibri; font-size:15px">Reservations:</p>

<table border="1" style="border-collapse:collapse" width="100%">
<thead>
    <tr style="background-color: #ccecff">
        <th style="padding:5px; background-color:#ccecff; width:5%; font-family:Calibri; font-size:15px"></th>
        <th style="padding:5px; background-color:#ccecff; width:28%; font-family:Calibri; font-size:15px">Name</th>
        <th style="padding:5px; background-color:#ccecff; width:23%; font-family:Calibri; font-size:15px">Country/State</th>
        <th style="padding:5px; background-color:#ccecff; width:23%; font-family:Calibri; font-size:15px">How did you hear about the VOA Studio tour?</th>
        <th style="padding:5px; background-color:#ccecff; width:10%; font-family:Calibri; font-size:15px">Attended</th>
        <th style="padding:5px; background-color:#ccecff; width:10%; font-family:Calibri; font-size:15px">Did not attend</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td style="padding:5px; width:5%; font-family:Calibri; font-size:15px">1</td>
        <td style="padding:5px; width:28%; font-family:Calibri; font-size:15px">{$reservation.organizer_name}</td>
        <td style="padding:5px; width:23%; font-family:Calibri; font-size:15px"></td>
        <td style="padding:5px; width:23%; font-family:Calibri; font-size:15px">{$reservation.interests}</td>
        <td style="padding:5px; width:10%; font-family:Calibri; font-size:15px"></td>
        <td style="padding:5px; width:10%; font-family:Calibri; font-size:15px"></td>
    </tr>
{if isset($reservation.guests)}
{foreach from=$reservation.guests item=guest}
    <tr>
        <td style="padding:5px; width:5%; font-family:Calibri; font-size:15px">{$guest@index + 2}</td>
        <td style="padding:5px; width:28%; font-family:Calibri; font-size:15px">{$guest}</td>
        <td style="padding:5px; width:23%; font-family:Calibri; font-size:15px"></td>
        <td style="padding:5px; width:23%; font-family:Calibri; font-size:15px"></td>
        <td style="padding:5px; width:10%; font-family:Calibri; font-size:15px"></td>
        <td style="padding:5px; width:10%; font-family:Calibri; font-size:15px"></td>
    </tr>
{/foreach}
{/if}
</tbody>
</table>

<h3 style="font-family:Calibri; font-size:15px">Walk-Ins:</p>

<table border="1" style="border-collapse:collapse" width="100%">
<thead>
    <tr style="background-color: #ccecff">
        <th style="padding:5px; background-color:#ccecff; width:5%; font-family:Calibri; font-size:15px"></th>
        <th style="padding:5px; background-color:#ccecff; width:28%; font-family:Calibri; font-size:15px">Name</th>
        <th style="padding:5px; background-color:#ccecff; width:23%; font-family:Calibri; font-size:15px">Country/State</th>
        <th style="padding:5px; background-color:#ccecff; width:43%; font-family:Calibri; font-size:15px">How did you hear about the VOA Studio tour?</th>
    </tr>
</thead>
<tbody>
{for $i = 0 to 10}
<tr>
    <td style="padding:5px; width:5%; font-family:Calibri; font-size:15px"></td>
    <td style="padding:5px; width:28%; font-family:Calibri; font-size:15px"></td>
    <td style="padding:5px; width:23%; font-family:Calibri; font-size:15px"></td>
    <td style="padding:5px; width:23%; font-family:Calibri; font-size:15px"></td>
</tr>
{/for}
</tbody>
</table>
