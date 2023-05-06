<%= link_to player_favorite_path(id: current_user.favorites.find_by(player_id: player.id).id, player_id: player.id), class:"float-left", method: :delete, remote: true do %>
	<i class="fa-solid fa-star"></i>
<% end %>
