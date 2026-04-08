# Keep bash login shells aligned with shared profile logic.
if [ -f "$HOME/.profile" ]; then
  . "$HOME/.profile"
fi
