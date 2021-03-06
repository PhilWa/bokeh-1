utils = require "../../utils"
sinon = require 'sinon'

{Document} = utils.require("document")
Range1d = utils.require("models/ranges/range1d").Model
Plot = utils.require("models/plots/plot").Model
GlyphRenderer = utils.require("models/renderers/glyph_renderer").Model
ColumnDataSource = utils.require('models/sources/column_data_source').Model
PlotCanvasView = utils.require('models/plots/plot_canvas').View

create_glyph_view = (glyph) ->
  ###
  Requires stubbing the canvas and solver before calling
  ###
  doc = new Document()
  plot = new Plot({
    x_range: new Range1d({start: 0, end: 1})
    y_range: new Range1d({start: 0, end: 1})
  })
  doc.add_root(plot)
  plot_view = new plot.plot_canvas.default_view({model: plot.plot_canvas })
  sinon.stub(plot_view, 'update_constraints')

  @data_source = new ColumnDataSource()

  glyph_renderer = new GlyphRenderer({
    glyph: glyph
    data_source: @data_source
  })

  glyph_renderer_view = new glyph_renderer.default_view({
    model: glyph_renderer
    plot_model: plot.plot_canvas
    plot_view: plot_view
  })

  return glyph_renderer_view.glyph

module.exports = {
  create_glyph_view: create_glyph_view
}
