import Link from "next/link";
import React from "react";

const PromoBanner: React.FC = () => {
  return (
    <Link
      href="https://hubstack-simple-auth.vercel.app/"
      target="_blank"
      className="bg-blue-600 text-white py-2 flex justify-center items-center sticky top-0 h-10 inset-0 z-[999] text-sm"
    >
      <div className="flex items-center space-x-2">
        <span className="text-yellow-400">✨</span>
        <p className=" font-semibold">
          Introducing{" "}
          <span className="underline">Hubstack Next.js Starter Kit</span> try it
          now 🚀
        </p>
      </div>
    </Link>
  );
};

export default PromoBanner;
