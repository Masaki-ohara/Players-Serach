<%= link_to  favorites_players_url(player_id: player.id), id: "js-bookmark-button-for-board-#{player.id}", class:"float-right", method: :post do %>
    <%= icon 'far', 'star' %>
    <% end %>