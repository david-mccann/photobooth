#include "maskedmousearea.h"

#include <QGuiApplication>
#include <QStyleHints>
#include <qqmlfile.h>

MaskedMouseArea::MaskedMouseArea(QQuickItem* parent)
    : QQuickItem(parent)
    , m_pressed(false)
    , m_containsMouse(false) {
  setAcceptHoverEvents(true);
  setAcceptedMouseButtons(Qt::LeftButton);
}

void MaskedMouseArea::setPressed(bool pressed) {
  if (m_pressed != pressed) {
    m_pressed = pressed;
    emit pressedChanged();
  }
}

void MaskedMouseArea::setContainsMouse(bool containsMouse) {
  if (m_containsMouse != containsMouse) {
    m_containsMouse = containsMouse;
    emit containsMouseChanged();
  }
}

void MaskedMouseArea::setMaskSource(const QUrl& source) {
  if (m_maskSource != source) {
    m_maskSource = source;
    m_maskImage = QImage(QQmlFile::urlToLocalFileOrQrc(source));
    emit maskSourceChanged();
  }
}

bool MaskedMouseArea::contains(const QPointF& point) const {
  if (!QQuickItem::contains(point) || m_maskImage.isNull())
    return false;

  QPoint p = point.toPoint();

  if (p.x() < 0 || p.x() >= m_maskImage.width() || p.y() < 0 || p.y() >= m_maskImage.height())
    return false;

  return qAlpha(m_maskImage.pixel(p)) >= 0.99;
}

void MaskedMouseArea::mousePressEvent(QMouseEvent* event) {
  setPressed(true);
  m_pressPoint = event->pos();
  emit pressed();
}

void MaskedMouseArea::mouseReleaseEvent(QMouseEvent* event) {
  setPressed(false);
  emit released();

  const int threshold = qApp->styleHints()->startDragDistance();
  const bool isClick = (threshold >= qAbs(event->x() - m_pressPoint.x()) && threshold >= qAbs(event->y() - m_pressPoint.y()));

  if (isClick)
    emit clicked();
}

void MaskedMouseArea::mouseUngrabEvent() {
  setPressed(false);
  emit canceled();
}

void MaskedMouseArea::hoverEnterEvent(QHoverEvent* event) {
  Q_UNUSED(event);
  setContainsMouse(true);
}

void MaskedMouseArea::hoverLeaveEvent(QHoverEvent* event) {
  Q_UNUSED(event);
  setContainsMouse(false);
}
