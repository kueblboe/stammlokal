Template.menuItem.helpers
  formattedPrice: ->
    "#{@price.toFixed(2).replace(/\./g, ',')} €"