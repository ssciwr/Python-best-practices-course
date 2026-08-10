#import "@preview/touying:0.7.4": *

#let _rule(height, fill) = rect(
  width: 100%,
  height: height,
  fill: fill,
  stroke: none,
)

#let _logo(info, height, override: auto) = {
  let logo = if override == auto {
    info.logo
  } else {
    override
  }
  if logo != none {
    box(height: height, {
      set image(height: height)
      logo
    })
  } else {
    none
  }
}

#let _display-date(self, info) = if info.date == none {
  none
} else if type(info.date) == datetime {
  info.date.display(self.at("datetime-format", default: auto))
} else {
  info.date
}

/// Default slide function for the institution theme.
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  title: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let header(self) = {
    set std.align(top)
    pad(
      top: self.store.slide-header-top,
      grid(
        rows: (auto, auto),
        row-gutter: self.store.header-rule-gap,
        box(
          height: self.store.slide-logo-height,
          align(
            horizon,
            components.left-and-right(
              align(horizon)[
                #text(
                  fill: self.colors.neutral-darkest,
                  weight: "bold",
                  size: 1.05em,
                  if title != auto {
                    utils.fit-to-width(grow: false, 100%, title)
                  } else {
                    utils.call-or-display(self, self.store.header)
                  },
                )
              ],
              _logo(
                self.info,
                self.store.slide-logo-height,
                override: self.store.slide-logo,
              ),
            ),
          ),
        ),
        _rule(self.store.header-rule-height, self.colors.primary),
      ),
    )
  }
  let footer(self) = {
    set std.align(bottom)

    pad(
      bottom: .5em,
      components.left-and-right(
        text(
          size: .6em,
          fill: self.colors.neutral-darkest,
          utils.display-current-heading(
            level: 1,
            depth: self.slide-level,
            numbered: true,
          ),
        ),
        text(
          size: .6em,
          fill: self.colors.neutral-darkest,
          context utils.slide-counter.display()
            + " / "
            + utils.last-slide-number,
        ),
      ),
    )
  }
  let self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
    config-common(subslide-preamble: self.store.subslide-preamble),
  )
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: setting,
    composer: composer,
    ..bodies,
  )
})

/// Title slide for the institution theme.
#let title-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: self.store.dark-background, margin: 0em),
    config,
  )

  let date = _display-date(self, info)
  let body = {
    set text(fill: self.colors.neutral-lightest)

    place(
      top + right,
      dx: -self.store.title-margin-x,
      dy: self.store.title-margin-y,
      _logo(info, self.store.title-logo-height, override: self.store.title-logo),
    )

    place(
      left + horizon,
      dx: self.store.title-margin-x,
      block(width: 100% - 2 * self.store.title-margin-x, {
        if info.title != none {
          align(left)[#text(size: 2em, weight: "bold", info.title)]
        }
        _rule(self.store.title-rule-height, self.colors.primary)
        if info.author != none and info.institution != none {
          text(size: 1em, [#info.author, #info.institution])
        }
        else if info.author != none {
          text(size: 1em, info.author)
        }
      }),
    )

    if date != none {
      place(
        bottom + right,
        dx: -self.store.title-margin-x,
        dy: -self.store.bottom-rule-height - .9em,
        text(size: .65em, fill: self.colors.primary, [Last updated: #date]),
      )
    }

    place(bottom, _rule(self.store.bottom-rule-height, self.colors.primary))
  }
  touying-slide(self: self, body)
})

/// Section slide for the institution theme.
#let new-section-slide(config: (:), body) = touying-slide-wrapper(self => {
  let section-header(self) = {
    set std.align(top)
    pad(
      top: self.store.slide-header-top,
      components.left-and-right(
        none,
        _logo(
          self.info,
          self.store.slide-logo-height,
          override: self.store.slide-logo,
        ),
      ),
    )
  }

  let self = utils.merge-dicts(
    self,
    config-page(header: section-header),
  )

  let slide-body = {
    set text(fill: self.colors.primary, weight: "bold", size: 1.45em)
    block(width: 75%, {
      utils.display-current-heading(level: 1)
      v(.55em)
      _rule(2pt, self.colors.primary)
    })
    body
  }

  touying-slide(self: self, config: config, align(horizon, slide-body))
})

/// Institution theme.
#let institution-theme(
  aspect-ratio: "16-9",
  primary: rgb("3a9ebf"),
  dark-background: rgb("1f2a30"),
  header: self => utils.display-current-heading(
    setting: utils.fit-to-width.with(grow: false, 100%),
    level: 2,
    depth: self.slide-level,
  ),
  title-logo-height: 2.5em,
  slide-logo-height: 2em,
  title-logo: auto,
  slide-logo: auto,
  title-margin-x: 2em,
  title-margin-y: 1.6em,
  slide-margin-x: 2.2em,
  slide-header-top: 2em,
  header-rule-gap: .35em,
  header-body-gap: 1.15em,
  title-rule-height: 2pt,
  header-rule-height: 1.2pt,
  bottom-rule-height: 8pt,
  subslide-preamble: none,
  ..args,
  body,
) = {
  let slide-margin-top = (
    slide-header-top
      + slide-logo-height
      + header-rule-gap
      + header-rule-height
      + header-body-gap
  )

  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      margin: (top: slide-margin-top, bottom: 1.5em, x: slide-margin-x),
      header-ascent: 0em,
      footer-descent: 0em,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
      zero-margin-header: false,
      zero-margin-footer: false,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: 20pt)
        show heading.where(level: 3): set text(fill: self.colors.primary)
        show heading.where(level: 4): set text(fill: self.colors.primary)
        show footnote.entry: set text(size: .6em)
        show link: it => if type(it.dest) == str {
          set text(fill: self.colors.primary)
          it
        } else {
          it
        }

        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: primary,
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: rgb("#000000"),
    ),
    config-store(
      dark-background: dark-background,
      header: header,
      title-logo-height: title-logo-height,
      slide-logo-height: slide-logo-height,
      title-logo: title-logo,
      slide-logo: slide-logo,
      title-margin-x: title-margin-x,
      title-margin-y: title-margin-y,
      slide-margin-x: slide-margin-x,
      slide-header-top: slide-header-top,
      header-rule-gap: header-rule-gap,
      header-body-gap: header-body-gap,
      title-rule-height: title-rule-height,
      header-rule-height: header-rule-height,
      bottom-rule-height: bottom-rule-height,
      subslide-preamble: subslide-preamble,
    ),
    ..args,
  )

  body
}
