
<h1>Reservation Request</h1>

<p>Remote IP address: {$remote_ip}</p>

<ul>
    <li>Tour date: {$reservation.tour_date}</li>
    <li>Number of visitors: {$reservation.number_of_visitors}</li>
    <li>Type of tour: {$reservation.type_of_tour}</li>
    <li>Organizer: {$reservation.organizer_name}</li>
    <li>Organizer phone: {$reservation.organizer_phone}</li>
    <li>Organizer email: {$reservation.organizer_email}</li>
    <li><p>Guests</p>
        <ol>
{if isset($reservation.guests)}
{foreach from=$reservation.guests item=guest}
            <li>{$guest}</li>
{/foreach}
{/if}
        </ol>
    </li>
{if $reservation.type_of_tour == "Daily"}
    <li>How did you hear about the VOA tour: {$reservation.interests}</li>
{else}
    <li>Interests: {$reservation.interests}</li>
{/if}
    <li>Notes: {$reservation.notes}</li>
</ul>
