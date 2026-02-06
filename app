import { configureStore, createSlice } from "@reduxjs/toolkit";

const todoSlice = createSlice({
  name: "todo",
  initialState: [],
  reducers: {
    addTodo: (state, action) => {
      state.push({
        id: Date.now(),
        text: action.payload,
      });
    },
    deleteTodo: (state, action) => {
      return state.filter(t => t.id !== action.payload);
    },
  },
});

export const { addTodo, deleteTodo } = todoSlice.actions;

export const store = configureStore({
  reducer: {
    todo: todoSlice.reducer,
  },
});
import React from "react";
import ReactDOM from "react-dom/client";
import { Provider } from "react-redux";
import { store } from "./store";
import App from "./App";

ReactDOM.createRoot(document.getElementById("root")).render(
  <Provider store={store}>
    <App />
  </Provider>
);
import { useState } from "react";
import { useSelector, useDispatch } from "react-redux";
import { addTodo, deleteTodo } from "./store";

function App() {
  const [text, setText] = useState("");
  const todos = useSelector(state => state.todo);
  const dispatch = useDispatch();

  return (
    <div>
     <h3>Todo App</h3>

      <input
        value={text}        onChange={e => setText(e.target.value)}
      />
    <button
        onClick={() => {
        dispatch(addTodo(text));
          setText("");
        }}
      >
        Add
      </button>
      <ul>
        {todos.map(t => (          <li key={t.id}>
          {t.text}
          <button onClick={() => dispatch(deleteTodo(t.id))}>
              X
         </button>
</li>
        ))}
   </ul>
    </div>
  );
}

export default App;
