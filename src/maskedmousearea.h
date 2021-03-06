#ifndef MASKEDMOUSEAREA_H
#define MASKEDMOUSEAREA_H

#include <QImage>
#include <QQuickItem>

class MaskedMouseArea : public QQuickItem {
  Q_OBJECT
  Q_PROPERTY(bool pressed READ isPressed NOTIFY pressedChanged)
  Q_PROPERTY(bool containsMouse READ containsMouse NOTIFY containsMouseChanged)
  Q_PROPERTY(QUrl maskSource READ maskSource WRITE setMaskSource NOTIFY maskSourceChanged)

  public:
  MaskedMouseArea(QQuickItem* parent = 0);

  bool contains(const QPointF& point) const;

  bool isPressed() const { return m_pressed; }
  bool containsMouse() const { return m_containsMouse; }

  QUrl maskSource() const { return m_maskSource; }
  void setMaskSource(const QUrl& source);

  signals:
  void pressed();
  void released();
  void clicked();
  void canceled();
  void pressedChanged();
  void maskSourceChanged();
  void containsMouseChanged();

  protected:
  void setPressed(bool pressed);
  void setContainsMouse(bool containsMouse);
  void mousePressEvent(QMouseEvent* event);
  void mouseReleaseEvent(QMouseEvent* event);
  void hoverEnterEvent(QHoverEvent* event);
  void hoverLeaveEvent(QHoverEvent* event);
  void mouseUngrabEvent();

  private:
  bool m_pressed;
  QUrl m_maskSource;
  QImage m_maskImage;
  QPointF m_pressPoint;
  bool m_containsMouse;
};

#endif
