import java.util.*;

PFont font;
String input = "";     // 입력 중인 수식
String result = "";    // 계산 결과 또는 오류 메시지
boolean showResult = false;

void setup() {
  size(700, 200);
  font = createFont("AppleGothic", 18);
  textFont(font);
}

void draw() {
  background(30);
  fill(255);
  textAlign(LEFT, TOP);

  text("수식을 입력하세요 (Enter: 계산, Backspace: 지우기, Esc: 초기화)", 20, 20);

  fill(120, 220, 255);
  text("> " + input + "_", 20, 70);

  fill(255);
  if (showResult) {
    text(result, 20, 120);
  }
}

void keyPressed() {
  if (key == ENTER || key == RETURN) {
    calculate();
  } else if (key == BACKSPACE) {
    if (input.length() > 0) {
      input = input.substring(0, input.length() - 1);
    }
    showResult = false;
  } else if (key == ESC) {
    key = 0;  // 프로세싱이 ESC로 창을 닫지 않도록 막음
    input = "";
    result = "";
    showResult = false;
  } else if (isAllowed(key)) {
    input += key;
    showResult = false;
  }
}

// 입력 허용 문자: 숫자, 연산자, 괄호, 소수점, 공백
boolean isAllowed(char c) {
  return "0123456789+-*/^(). ".indexOf(c) >= 0;
}

void calculate() {
  if (input.trim().length() == 0) return;
  try {
    String postfix = convert(input);
    double value = evaluatePostfix(postfix);
    result = "후위 표기: " + postfix + "   =   " + value;
  } catch (IllegalArgumentException e) {
    result = "오류: " + e.getMessage();
  } catch (RuntimeException e) {
    result = "오류: 수식이 올바르지 않습니다.";
  }
  showResult = true;
}

// ----- 중위 → 후위 변환 -----

int precedence(char op) {
  switch (op) {
    case '+':
    case '-': return 1;
    case '*':
    case '/': return 2;
    case '^': return 3;
    default:  return -1;
  }
}

boolean isRightAssociative(char op) {
  return op == '^';
}

String convert(String infix) {
  StringBuilder output = new StringBuilder();
  Deque<Character> stack = new ArrayDeque<Character>();
  int i = 0;

  while (i < infix.length()) {
    char c = infix.charAt(i);

    if (Character.isWhitespace(c)) {
      i++;
      continue;
    }

    if (Character.isDigit(c) || c == '.') {
      while (i < infix.length()
          && (Character.isDigit(infix.charAt(i)) || infix.charAt(i) == '.')) {
        output.append(infix.charAt(i++));
      }
      output.append(' ');
      continue;
    }

    if (c == '(') {
      stack.push(c);
    } else if (c == ')') {
      while (!stack.isEmpty() && stack.peek() != '(') {
        output.append(stack.pop()).append(' ');
      }
      if (stack.isEmpty()) {
        throw new IllegalArgumentException("괄호 짝이 맞지 않습니다.");
      }
      stack.pop();
    } else if (precedence(c) > 0) {
      while (!stack.isEmpty()
          && stack.peek() != '('
          && (precedence(stack.peek()) > precedence(c)
              || (precedence(stack.peek()) == precedence(c)
                  && !isRightAssociative(c)))) {
        output.append(stack.pop()).append(' ');
      }
      stack.push(c);
    } else {
      throw new IllegalArgumentException("잘못된 문자: " + c);
    }
    i++;
  }

  while (!stack.isEmpty()) {
    char op = stack.pop();
    if (op == '(') {
      throw new IllegalArgumentException("괄호 짝이 맞지 않습니다.");
    }
    output.append(op).append(' ');
  }

  return output.toString().trim();
}

// ----- 후위 표기식 계산 -----

double evaluatePostfix(String postfix) {
  Deque<Double> stack = new ArrayDeque<Double>();
  for (String token : postfix.split("\\s+")) {
    if (token.isEmpty()) continue;
    if (token.length() == 1 && precedence(token.charAt(0)) > 0) {
      double b = stack.pop();
      double a = stack.pop();
      switch (token.charAt(0)) {
        case '+': stack.push(a + b); break;
        case '-': stack.push(a - b); break;
        case '*': stack.push(a * b); break;
        case '/': stack.push(a / b); break;
        case '^': stack.push(Math.pow(a, b)); break;
      }
    } else {
      stack.push(Double.parseDouble(token));
    }
  }
  return stack.pop();
}
